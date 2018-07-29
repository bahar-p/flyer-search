# flyer items
class FlyerItem
  attr_accessor :name
  attr_accessor :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  # @return [Boolean] true if it matches the name to search for
  def match?(name)
    true if /\w*#{name}\w*/i =~ @name
  end

end