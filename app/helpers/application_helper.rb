module ApplicationHelper

  def semantic_icon(icon, options = {})
    return icon_tag(icon, false, options)
  end

  def interactive_icon(icon, options = {})
    return icon_tag(icon, true, options)
  end

  private

  def icon_tag(icon, is_interactive, options = {})
    wrapper_options = {
      class: (icon.fa_bg_name ? "icon-with-bg" : "icon-without-bg")
    }
    wrapper_options[:class] += " interactive-icon" if is_interactive
    wrapper_options[:class] += " #{options.delete(:class)}" if options[:class]
    wrapper_options[:aria] = { label: icon.meaning } if is_interactive
    wrapper_options.merge!(options)

    meaning_tag = nil
    if !is_interactive
      meaning_tag = content_tag(:span, icon.meaning, class: "screenreader-only")
    end

    icon_options = {
      class: "icon",
      title: icon.meaning,
      aria: { hidden: true },
    }
    icon_tag = content_tag(:i, nil, icon_options) { meaning_tag }

    background_icon_tag = content_tag(:i, nil, class: "icon-bg fa-lg")

    content_tag(:span, nil, wrapper_options) do
      if icon.fa_bg_name
        background_icon_tag + icon_tag
      else
        icon_tag
      end
    end
  end

end
