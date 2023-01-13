require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe FoodTruck do
  let(:item1) { Item.new({name: 'Peach Pie (Slice)', price: "$3.75"}) }
  let(:item2) { Item.new({name: 'Apple Pie (Slice)', price: "$2.50"}) }
  let(:item3) { Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"}) }
  let(:item4) { Item.new({name: "Banana Nice Cream", price: "$4.25"}) }
  let(:food_truck1) { FoodTruck.new("Rocky Mountain Pies") }
  let(:food_truck2) { FoodTruck.new("Ba-Nom-a-Nom") }
  let(:food_truck3) { FoodTruck.new("Palisade Peach Shack") }
  let(:event) { Event.new("South Pearl Street Farmers Market") }


  describe '#initialize' do
    it 'exists' do
      expect(event).to be_an(Event)
    end

    it 'has attributes' do
      expect(event.name).to eq("South Pearl Street Farmers Market")
      expect(event.food_trucks).to eq([])
    end
  end

  describe 'can add food trucks and give information about their wares and potential revenue' do
    before do
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck2.stock(item4, 50)    
      food_truck2.stock(item3, 25)
      food_truck3.stock(item1, 65)

      event.add_food_truck(food_truck1)    
      event.add_food_truck(food_truck2)    
      event.add_food_truck(food_truck3)
    end

    it 'can #add_food_truck' do
      expect(event.food_trucks).to eq([food_truck1, food_truck2, food_truck3])
    end

    it 'can give #food_truck_names' do
      expect(event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it 'can give #food_trucks_that_sell(certain items)' do
      expect(event.food_trucks_that_sell(item1)).to eq([food_truck1, food_truck3])
      expect(event.food_trucks_that_sell(item4)).to eq([food_truck2])
    end

    it 'can calculate #potential_revenue per truck' do
      expect(food_truck1.potential_revenue).to eq(148.75)
      expect(food_truck2.potential_revenue).to eq(345.00)
      expect(food_truck3.potential_revenue).to eq(243.75)
    end
  end

  describe 'Iteration 3' do
    before do
      food_truck1.stock(item1, 35)
      food_truck1.stock(item2, 7)
      food_truck2.stock(item4, 50)    
      food_truck2.stock(item3, 25)
      food_truck3.stock(item1, 65)

      event.add_food_truck(food_truck1)    
      event.add_food_truck(food_truck2)    
      event.add_food_truck(food_truck3)
    end

    it 'can tell if #overstocked_items' do
      expect(event.overstocked_items).to eq([item1])
    end

    it 'can #list_all_food_names from all trucks alphabetically' do
      expect(event.list_all_food_names).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
    end

    it 'can give a #total_inventory hash with total quantity and trucks where available' do
      expected = {
        item1=>{:total_quantity=>100, :food_trucks=>[food_truck1, food_truck3]},
        item2=>{:total_quantity=>7, :food_trucks=>[food_truck1]},
        item4=>{:total_quantity=>50, :food_trucks=>[food_truck2]},
        item3=>{:total_quantity=>25, :food_trucks=>[food_truck2]}
      }
      expect(event.total_inventory).to eq(expected)
    end
  end
end