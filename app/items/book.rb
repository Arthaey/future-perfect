class Book < Item
  include ActionView::Helpers::UrlHelper

  attr_accessor :title, :author
  attr_accessor :source_url

  def initialize(description = "", params = {})
    begin
      uri = URI.parse(description)
      @source_url = uri if uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    rescue URI::InvalidURIError => err
      # don't set @source_url
    end

    if @source_url
      metadata = MetadataSource.for(@source_url)
      if metadata
        @title = metadata[:title]
        @author = metadata[:author]
      end
    else
      @title = description
    end

    super(@title, params)
  end

  def display
    if @title
      str = "“#{@title}”"
      str << " by #{@author}" unless @author.blank?
      str
    elsif @source_url
      link_to(@source_url.to_s, @source_url.to_s)
    else
      super
    end
  end

  def default_category
    GoalCategory[:relaxing]
  end
end
