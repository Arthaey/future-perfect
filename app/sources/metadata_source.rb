class MetadataSource
  @@agent = Mechanize.new

  def self.for(uri)
    case uri.host
    when /\bamazon\.com$/
      Amazon(uri)
    when /\bgoodreads\.com$/
      GoodReads(uri)
    when /\btwitter\.com$/
      Twitter(uri)
    end
  end

  def self.Amazon(uri)
    page = @@agent.get(uri)
    {
      title: get_text(page, "#productTitle"),
      author: get_text(page, ".author .contributorNameID"),
    }
  end

  def self.GoodReads(uri)
    page = @@agent.get(uri)
    {
      title: get_text(page, "#bookTitle"),
      author: get_text(page, ".authorName"),
    }
  end

  def self.Twitter(uri)
    page = @@agent.get(uri)

    tweet = page.at(".tweet")
    text = tweet.at(".tweet-text").children.first.text
    user = tweet.attributes["data-screen-name"].value

    {
      text: text,
      user: user,
    }
  end

  private

  def self.get_text(page, selector)
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
