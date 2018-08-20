require_relative '../flyer/flyer'
require_relative '../flyer/flyer_item'

# implements methods to parse flyer pages
class Farmboy < Flyer

  FARMBOY_URL =  "https://www.farmboy.ca/weekly-specials/ottawa/weekly-specials-list/".freeze
  STORE_NAME = "farmboy".freeze

  # parse flyer items with their price
  # @return [Array<FlyerItems>] array of flyer items with their price
  def flyer_items
    doc.css("div[style='float:left;margin-right:5px;']").map do |i|
      price = i.next_element.text
      price = price.sub('/', ' for').strip
      FlyerItem.new(i.text, price)
    end
  end

  # @return [String] store flyer name
  def name
    STORE_NAME
  end

  # @return [String] store flyer url
  def url
    FARMBOY_URL
  end

end


