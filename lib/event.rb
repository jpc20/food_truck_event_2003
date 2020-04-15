class Event

  attr_reader :name, :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map {|food_truck| food_truck.name}
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all {|food_truck| food_truck.inventory.include?(item)}
  end

  def total_inventory
    total_inventory = Hash.new { |hash, key| hash[key] = {quantity: 0, food_trucks: []} }
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, quantity|
        total_inventory[item][:quantity] += quantity
        total_inventory[item][:food_trucks] << food_truck
      end
    end
    total_inventory
  end

  def overstocked_items
    overstocked_items = []
    total_inventory.each do |item, hash|
      if hash[:quantity] > 50 && hash[:food_trucks].length > 1
        overstocked_items << item
      end
    end
    overstocked_items
  end

  def sorted_item_list
    total_inventory.keys.map { |item| item.name }.sort
  end

  def date
    Date.today.strftime("%d/%m/%Y")
  end

  def sell(item, quantity)
    item_quantity = quantity
    return false if food_trucks_that_sell(item).empty?
    return false if total_inventory[item][:quantity] <= quantity
    until item_quantity <= 0
      food_truck = food_trucks.find do |food_truck|
        food_truck.check_stock(item) > 0
      end
      item_quantity -= food_truck.check_stock(item)
      food_truck.inventory[item] -= item_quantity
    end
    return true
  end

end
