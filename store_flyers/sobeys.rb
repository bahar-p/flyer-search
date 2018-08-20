require_relative '../flyer/flyer_item'
require_relative '../flyer/flyer'

# implements methods to parse sobeys flyer
class Sobeys < Flyer

  SOBEYS_URL =  "https://flyers.sobeys.com/flyers/sobeys-sobeysurbanfresh/grid_view/286283?type=2&locale=en&store_code=4711&hide=special%2Cpub"
  STORE_NAME = "sobeys".freeze

  # overrides flyer items to get sobeys flyer items with their price
  # @return [Array<FlyerItems>] array of flyer items with their price
  def flyer_items
    doc.css('span.wishabi-offscreen').each_with_object [] do |i, results|
      details = i.text.strip.split("\n")
      name = details[0].strip
      next if name =~ /^This link opens a .*$/
      price = if details[1].nil?
                "Unknown"
              else
                details[1].strip
              end
      results << FlyerItem.new(name, price)
    end
  end

  # @return [String] store flyer name
  def name
    STORE_NAME
  end

  # @return [String] store flyer url
  def url
    SOBEYS_URL
  end

end