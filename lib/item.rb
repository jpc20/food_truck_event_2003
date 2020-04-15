class Item

  attr_reader :name, :price
  def initialize(information)
    @name = information[:name]
    @price = information[:price].delete("$").to_f
  end
end
