class Item
  include ActiveModel::Model
  extend ActiveModel::Naming

  attr_accessor :description
  attr_accessor :due_at, :completed_at

  def initialize(description = "", params = {})
    @description = description

    when_str = params.delete(:when)
    if when_str
      if DateTime.parse(when_str) > DateTime.now
        @due_at = when_str
      else
        @completed_at = when_str
      end
    end

    params.each { |key, value| send "#{key}=", value }
  end

  # Subclasses should override this method to customize their appaearance.
  def display
    description
  end

  def type
    model_name.name
  end

  def icon
    Icon.for(type) || Icon.circle
  end

  def timestamp
    completed_at || due_at
  end

  def weekday
    timestamp ? DateTime.parse(timestamp).strftime("%a") : nil
  end

  def relative_time
    if completed_at
      DateTime.parse(completed_at).strftime("%-I%P")
    elsif due_at
      DateTime.parse(due_at).strftime("%a")
    end
  end
end
