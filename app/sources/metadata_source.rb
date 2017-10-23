class MetadataSource
  @@agent = Mechanize.new

  def self.for(uri)
    case uri.host
    when /\bamazon\.com$/
      Amazon(uri)
    when /\bgoodreads\.com$/
      GoodReads(uri)
    end
  end

  def self.Amazon(uri)
    page = @@agent.get(uri)
    {
      title: find_css(page, "#productTitle"),
      author: find_css(page, ".author .contributorNameID")
    }
  end

  def self.GoodReads(uri)
    page = @@agent.get(uri)
    {
      title: find_css(page, "#bookTitle"),
      author: find_css(page, ".authorName")
    }
  end

  private

  def self.find_css(page, selector)
    text = page.at(selector).text
    text.gsub!(/\(.*\)/, '')
    text.strip
  end
end

# promise = Concurrent::Promise.new
# async_thing do
#   promise.set(value)
# end
# return promise
