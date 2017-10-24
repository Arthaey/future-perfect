class Tweet < Item
  include ActionView::Helpers::UrlHelper

  attr_accessor :text, :user
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
        @user = metadata[:user]
      end
    else
      @text = description
    end

    super(@text, params)
  end

  def display
    link_to("tweet", description)
  end

  def display
    if @text
      str = "“#{@text}”"
      str = "@#{@user}: #{str}" unless @user.blank?
      unless @source_url.blank?
        str << " ["
        str << link_to("source", @source_url.to_s)
        str << "]"
      end
      str.html_safe
    elsif @source_url
      link_to(@source_url.to_s, @source_url.to_s)
    else
      super
    end
  end
end
