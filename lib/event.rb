class Event
  attr_reader :name,
              :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks.push(truck)
  end

  def food_truck_names
    @food_trucks.map do |truck|
      truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.select do |truck|
      truck.inventory.include?(item)
    end
  end

  def total_similar_items
    total_similar_items = Hash.new(0)
    @food_trucks.each do |truck|
      truck.inventory.each do |item, quantity|
        total_similar_items[item] += quantity
      end
    end
    total_similar_items
  end

  def overstocked_items
    find_item = total_similar_items.select do |item, quantity|
      item if quantity > 50 && food_trucks_that_sell(item).count > 1
    end
    find_item.keys
  end

  def list_all_food_names
    total_similar_items.map do |item, quantity|
      item.name
    end.sort
  end

  def total_inventory
    total_inventory_hash = {}
    total_similar_items.each do |item, quantity|
      total_inventory_hash[item] = {
        total_quantity: quantity,
        food_trucks: food_trucks_that_sell(item)
      }
    end
    total_inventory_hash
    # require 'pry'; binding.pry
  end
  
end