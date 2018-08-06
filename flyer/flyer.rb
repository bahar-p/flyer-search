require  'nokogiri'
require 'open-uri'
require_relative 'flyer_item'
require 'fileutils'
require 'logger'

#flyer impelements methods to interact with flyers
class Flyer

  # @param url [String] flyer url
  # @param store [String] store name
  def initialize(url, store)
    @url = url
    @store = store
    @fname = File.join("cache", "#{@store}.html")
    @logger = Logger.new(STDOUT)
  end

  # parsed html page
  # @return [Nokogiri::HTML::Document] flyer data
  def doc
    return @doc if defined?(@doc)
    File.exist?(@fname) ? read_flyer : load_from_url
  rescue => e
    @logger.error "Error occured reading #{@store} flyer: #{e.inspect}"
    #File.exist?(@store) ? update_cache : write_cache
  end

  # load flyer data from url
  def load_from_url
    @logger.info "Reading #{@store} flyer content from the website"
    response = open(@url)
    @doc = Nokogiri::HTML(response)
    write_cache
    @doc
  rescue => e
    @logger.error "Could not load flyer url. Error: #{e.inspect}"
  end


  # @return [Boolean] true if flyer is outdated
  def outdated?
    # flyers update every week
    last_modfied = File.mtime(@fname)
    current_time = Time.now
    (current_time - last_modfied).abs.to_i / (24 * 3600) >= 7
  end

  # write flyer data to cache
  def write_cache
    @logger.info "Caching #{@store} flyer content"
    FileUtils.mkdir_p 'cache'
    File.open(@fname, 'wb') { |f| f.write @doc}
  rescue => e
    @logger.error "Error writing #{@store} flyer to cache: #{e.inspect}"
  end

  # load flyer content
  def read_flyer
    outdated? ? load_from_url : read_cache
  end

  # load flyer data from cache
  def read_cache
    @logger.info "Loading #{@store} flyer content from cache"
    @doc = File.open(@fname) {|f| Nokogiri::HTML(f)}
  end

  # flyer items
  # @param return [Array] array of flyer items
  def flyer_items
    return []
  end

  # check whether an item is on sale and gets its price
  # @param name [String] item name to search for
  def find_on_sale(name)
    flyer_items.find do |i|
      i.match?(name) unless i.nil?
    end
  end

end
