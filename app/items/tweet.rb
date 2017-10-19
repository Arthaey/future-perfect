class Tweet < Item
  include ActionView::Helpers::UrlHelper

  def display
    link_to("tweet", description)
  end
end
