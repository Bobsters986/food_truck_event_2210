require './lib/food_truck'
require './lib/item'

RSpec.describe FoodTruck do
  let(:item1) { Item.new({name: 'Peach Pie (Slice)', price: "$3.75"}) }
  let(:item2) { Item.new({name: 'Apple Pie (Slice)', price: "$2.50"}) }
  let(:food_truck) { FoodTruck.new("Rocky Mountain Pies") }


  describe '#initialize' do
    it 'exists' do
      expect(food_truck).to be_a(FoodTruck)
    end

    it 'has attributes' do
      expect(food_truck.name).to eq("Rocky Mountain Pies")
      expect(food_truck.inventory).to eq({})
    end
  end

  describe 'can #check_stock and #stock items' do
    it 'can #check_stock of items' do
      expect(food_truck.check_stock(item1)).to eq(0)
    end

    it 'can #stock items' do
      food_truck.stock(item1, 30)
      expect(food_truck.inventory).to eq({item1 => 30})

      food_truck.stock(item1, 25)
      expect(food_truck.inventory).to eq({item1 => 55})

      food_truck.stock(item2, 12)
      expect(food_truck.inventory).to eq({item1 => 55, item2 => 12})
    end

  end

end