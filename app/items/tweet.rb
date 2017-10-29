class Tweet < Item
  include ActionView::Helpers::UrlHelper

  attr_accessor :text, :username
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
        @text = metadata[:text]
        @username = metadata[:username]
      end
    else
      @text = description
    end

    super(@text, params)
  end

  def display
    if @text && @source_url
      ApplicationController.render(partial: "items/tweet", object: self)
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
