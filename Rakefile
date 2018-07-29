require_relative 'flyer/farmboy'
require_relative 'flyer/sobeys'

FARMBOY_URI =  "https://www.farmboy.ca/weekly-specials/ottawa/weekly-specials-list/".freeze
SOBEYS_URI =  "https://flyers.sobeys.com/flyers/sobeys-sobeysurbanfresh/grid_view/286283?type=2&locale=en&store_code=4711&hide=special%2Cpub".freeze

task :default => %w(:run)

desc "Search item for sale in store"
task :run do
  puts "which store? (options: Farmboy,Sobeys)"
  store = STDIN.gets.chomp
  puts "which item are you looking for?"
  item = STDIN.gets.chomp

  case store.downcase
  when "farmboy"
    flyer = Farmboy.new(FARMBOY_URI)
  when "sobeys"
    flyer = Sobeys.new(SOBEYS_URI)
  else
    puts "Flyer does not exist"
    return
  end

  flyer.flyer_items
  if result = flyer.find_on_sale(item)
    puts "\n#{result.name} is on sale for #{result.price} at #{store}\n"
  else
    puts "\n#{item} is not on sale this week\n"
  end

end
