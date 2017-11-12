module ApplicationHelper

  def to_css_id(str)
    str.to_s.strip.gsub(/\s+/, '-').gsub(/[^\w_-]/, '')
  end

  def semantic_icon(meaning, options = {})
    return icon_tag(meaning, false, options)
  end

  def interactive_icon(meaning, options = {})
    return icon_tag(meaning, true, options)
  end

  private

  def icon_tag(meaning, is_interactive, options = {})
    wrapper_options = { class: "icon-with-bg" }
    wrapper_options[:class] += " interactive-icon" if is_interactive
    wrapper_options[:class] += " #{options.delete(:class)}" if options[:class]
    wrapper_options[:aria] = { label: meaning } if is_interactive
    wrapper_options.merge!(options)

    meaning_tag = nil
    if !is_interactive
      meaning_tag = content_tag(:span, meaning, class: "screenreader-only")
    end

    icon_options = {
      class: "icon",
      title: meaning,
      aria: { hidden: true },
    }

    icon_tag = content_tag(:i, nil, icon_options) { meaning_tag }
    background_icon_tag = content_tag(:i, nil, class: "icon-bg fa-lg")

    content_tag(:span, nil, wrapper_options) do
      background_icon_tag + icon_tag
    end
  end

end
