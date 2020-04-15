require 'minitest/autorun'
require 'minitest/pride'
require './lib.food_truck'
require './lib/item'

class FoodTruckTest < Minitest::Test

  def setup
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  def test_it_has_a_name
    assert_equal "Rocky Mountain Pies", @food_truck.name
  end

  def test_inventory_empty_hash_default
    assert_equal ({}), @food_truck.inventory
  end
end
