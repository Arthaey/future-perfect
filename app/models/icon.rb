Icon = Struct.new(:meaning, :fa_name, :fa_bg_name)

class Icon
  ICON_MISSING = Icon.new("NO FA ICON FOR #{name}", "no-fa-icon-for-#{name}")

  def self.method_missing(name)
    ICON_MAPPINGS[name] || ICON_MISSING
  end

  def self.for_type(type)
    case type
    when "apt"
      Icon.appointment
    when "fun"
      Icon.fun
    when "task"
      Icon.completed_task
    else
      Icon.circle
    end
  end
end
