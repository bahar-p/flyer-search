require_relative 'flyer/farmboy'
require_relative 'flyer/sobeys'

task default: %w(run)

desc "Search item for sale in stores"
task :run, [:store, :item] do |t,args|
  #ruby "/Users/bahar/RubymineProjects/flyer-search/main.rb"
  case args.store.downcase
  when "farmboy"
    url = "https://www.farmboy.ca/weekly-specials/ottawa/weekly-specials-list/"
    flyer = Farmboy.new(url)
  when "sobeys"
    url = "https://flyers.sobeys.com/flyers/sobeys-sobeysurbanfresh/grid_view/286283?type=2&locale=en&store_code=4711&hide=special%2Cpub"
    flyer = Sobeys.new(url)
  end

  flyer.flyer_items
  if result = flyer.find_on_sale("#{args.item}")
    puts "\n#{result.name} is on sale for #{result.price}\n"
  end

end
