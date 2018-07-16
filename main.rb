require_relative 'flyer/flyer'

farmboy_url = "https://www.farmboy.ca/weekly-specials/ottawa/weekly-specials-list/"

fb_flyer = Flyer.new(farmboy_url)
if result = fb_flyer.find_on_sale("Granola Bars")
  puts "\n#{result.name} is on sale for #{result.price}\n"
end
