require_relative 'flyer_item'

#flyer class
class Flyer

  def initialize(url)
    @url = url
  end

  def doc
    return @doc if defined?(@doc)
    response = open(@url)
    @doc = Nokogiri::HTML(response)
  end

  # flyer items
  # @param return [Array] array of flyer items
  def flyer_items
    return []
  end

  # check whether an item is on sale and prints its price if it is
  # @param name [String] item name to search for
  def find_on_sale(name)
    flyer_items.find do |i|
      i.match?(name) unless i.nil?
    end
  end

end
