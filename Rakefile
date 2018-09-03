# frozen_string_literal: true
require_relative 'flyer/flyer'

task default: %w(:run)

desc "Search item for sale in store"
task :run do
  puts "Which store? (options: #{Flyer.descendants})"
  store = STDIN.gets.chomp

  begin
  flyer = Flyer.store_finder(store)

  puts "What item are you looking for?"
  item = STDIN.gets.chomp

  flyer.flyer_items
  if result = flyer.find_on_sale(item)
    puts "\n#{result.name} is on sale for #{result.price} at #{flyer.name}\n"
  else
    puts "\n#{item} is not on sale this week\n"
  end
  rescue RuntimeError => e
    puts "Error Occured in flyer search. Error: #{e.message}"
  end

end
