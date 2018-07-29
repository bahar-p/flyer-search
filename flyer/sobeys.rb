require_relative 'flyer_item'
require_relative 'flyer'

# implements methods to parse sobeys flyer
class Sobeys < Flyer

  # overrides flyer items to get sobeys flyer items with their price
  # @return [Array<FlyerItems>] array of flyer items with their price
  def flyer_items
    doc.css('span.wishabi-offscreen').map do |i|
      details = i.text.strip.split("\n")
      name = details[0].strip
      next if name =~ /^This link opens a .*$/
      price = if details[1].nil?
                "Unknown"
                else
                  details[1].strip
              end
      FlyerItem.new(name, price)
    end
  end

end