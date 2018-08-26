# frozen_string_literal: true
require_relative 'flyer/flyer'

task default: %w(:run)

desc "Search item for sale in store"
task :run do
  puts "which store? (options: Farmboy,Sobeys)"
  store = STDIN.gets.chomp

  flyer = Flyer.store_finder(store)

  puts "which item are you looking for?"
  item = STDIN.gets.chomp

  flyer.flyer_items
  if result = flyer.find_on_sale(item)
    puts "\n#{result.name} is on sale for #{result.price} at #{store}\n"
  else
    puts "\n#{item} is not on sale this week\n"
  end

end
