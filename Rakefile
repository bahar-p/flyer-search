# frozen_string_literal: true

require_relative 'store_flyers/farmboy'
require_relative 'store_flyers/sobeys'

task default: %w(:run)

desc "Search item for sale in store"
task :run do
  puts "which store? (options: Farmboy,Sobeys)"
  store = STDIN.gets.chomp
  flyer = case store.downcase
  when "farmboy"
    Farmboy.new
  when "sobeys"
    Sobeys.new
  else
    raise "no flyer found for #{store}"
  end

  puts "which item are you looking for?"
  item = STDIN.gets.chomp

  flyer.flyer_items
  if result = flyer.find_on_sale(item)
    puts "\n#{result.name} is on sale for #{result.price} at #{store}\n"
  else
    puts "\n#{item} is not on sale this week\n"
  end

end
