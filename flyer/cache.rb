require 'logger'

# implements flyer cache
class Cache

  # @param file_name [String] file name
  # @param [Logger] logger to log informations
  def initialize(file_name, logger: nil)
    @fname = file_name
    @logger = logger || Logger.new(STDOUT)
  end

  # load flyer data from cache
  def read
    @logger.info "Loading flyer from cache"
    Nokogiri::HTML(File.read(@fname))
  rescue => e
    raise "Error loading flyer from cache. Error: #{e.inspect}"
  end

  # cache flyer content
  def write(doc)
    @logger.info "Caching flyer"
    FileUtils.mkdir_p 'cache'
    File.write(@fname, doc.to_html)
  rescue => e
    @logger.error "Error caching flyer: #{e.inspect}"
  end

end