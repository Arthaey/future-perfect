class Scraper

  def self.for(uri)
    case uri.host
    when /\bamazon\.com$/
      Scraper.Amazon(uri)
    when /\bgoodreads\.com$/
      Scraper.GoodReads(uri)
    end
  end

  def self.Amazon(uri)
    promise = Concurrent::Promise.new
    
    agent = Mechanize.new
    agent.get(uri) do |page|
      title = page.search("#productTitle").text
      title.gsub!(/\(.*\)/, '')
      promise.set(title.strip)
    end

    promise
  end

  def self.GoodReads(uri)
    promise = Concurrent::Promise.new
    
    agent = Mechanize.new
    agent.get(uri) do |page|
      title = page.search("#bookTitle").text
      title.gsub!(/\(.*\)/, '')
      promise.set(title.strip)
    end

    promise
  end

end
