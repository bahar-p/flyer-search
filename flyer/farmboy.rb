require 'nokogiri'
require 'open-uri'
require_relative 'flyer_item'

# implements methods to parse flyer pages
class Flyer

  def initialize(url)
    @url = url
  end

  def doc
    return @doc if defined?(@doc)
    response = open(@url)
    @doc = Nokogiri::HTML(response)
  end

  # parse flyer items with their price
  # @return [Array<FlyerItems>] array of flyer items with their price
  def flyer_items
    doc.css("div[style='float:left;margin-right:5px;']").map do |i|
      price = i.next_element.text
      price = price.sub('/', ' for').strip
      FlyerItem.new(i.text, price)
    end
  end

  # check whether an item is on sale and prints its price if it is
  # @param name [String] item name to search for
  def find_on_sale(name)
    flyer_items.find do |i|
      i.match?(name)
    end
  end

end


