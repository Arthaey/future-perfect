class Book < Item
  include ActionView::Helpers::UrlHelper

  attr_accessor :title, :author
  attr_accessor :source_url

  def initialize(description = "", params = {})
    begin
      uri = URI.parse(description)
      @source_url = uri
      Scraper.for(uri).then { |t| @title = t }

    rescue URI::InvalidURIError => err
      @title = description
    end

    super(@title, params)
  end

  def display
    if title
      "“#{title}”"
    elsif source_url
      link_to(source_url.to_s, source_url.to_s)
    end
  end
end
