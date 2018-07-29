require_relative 'flyer'
require_relative 'flyer_item'


# implements methods to parse flyer pages
class Farmboy < Flyer

  # parse flyer items with their price
  # @return [Array<FlyerItems>] array of flyer items with their price
  def flyer_items
    doc.css("div[style='float:left;margin-right:5px;']").map do |i|
      price = i.next_element.text
      price = price.sub('/', ' for').strip
      FlyerItem.new(i.text, price)
    end
  end

end


