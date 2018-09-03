require  'nokogiri'
require 'open-uri'
require 'fileutils'
require 'logger'
require_relative 'flyer_item'
require_relative 'cache'

#flyer implements methods to interact with flyers
class Flyer

  singleton_class.send(:attr_reader, :descendants)

  def initialize
    @logger = Logger.new(STDOUT)
    @fname = File.join("cache", "#{self.name}.html")
    @cache = Cache.new(@fname)
  end

  # keep record of all flyer subclasses
  def self.inherited(subklass)
    @descendants ||= []
    @descendants << subklass
  end

  # instantiate store flyers dynamically by looking in descendants for store
  # @param name [String] store flyer name
  # @return [Flyer] instance of store flyer or nil if store flyer does not exist
  def self.store_finder(name)
    klass = @descendants.find {|c| /\s*#{name}\s*/i.match(c.name)}
    raise "no store flyer found for #{name}" if klass.nil?
    klass.new
  end

  # parse URL content
  # @return [Nokogiri::HTML::Document] flyer data
  def doc
    return @doc if defined?(@doc)
    File.exist?(@fname) ? load_flyer : load_from_url
  rescue => e
    @logger.error "Error occured reading #{self.name} flyer: #{e.inspect}"
  end

  # load flyer data from url
  def load_from_url
    @logger.info "Loading #{self.name} flyer url"
    response = open(self.url)
    @doc = Nokogiri::HTML(response)
    @cache.write(@doc)
    @doc
  rescue => e
    @logger.error "Could not load flyer url. Error: #{e.inspect}"
  end

  # check if flyer cache is outdated. Flyer gets updated every week
  # @return [Boolean] true if flyer is outdated
  def outdated?
    (Time.now - File.mtime(@fname)).abs.to_i / (24 * 3600) >= 6
  end

  # load flyer content
  def load_flyer
    outdated? ? load_from_url : @cache.read
  end

  # check whether an item is on sale and find its price
  # @param name [String] item name to search for
  def find_on_sale(name)
    flyer_items.find do |i|
      i.match?(name)
    end
  end

  # flyer items
  # @param return [Array] array of flyer items
  def flyer_items
    raise NotImplementedError
  end

  # @returns store flyer name
  def name
    raise NotImplementedError
  end

  # @return store flyer url
  def url
    raise NotImplementedError
  end

end

# dynamically require all existing store flyers
Dir['store_flyers/*.rb'].each do |f|
  require_relative "#{File.join('..',File.dirname(f), File.basename(f, '.rb'))}"
end
