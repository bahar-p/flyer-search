require  'nokogiri'
require 'open-uri'
require_relative 'flyer_item'


#flyer impelements methods to interact with flyers
class Flyer

  def initialize(url)
    @url = url
  end

  # parsed html page
  # @param return parsed html oage
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

  # check whether an item is on sale and gets its price
  # @param name [String] item name to search for
  def find_on_sale(name)
    flyer_items.find do |i|
      i.match?(name) unless i.nil?
    end
  end

end
