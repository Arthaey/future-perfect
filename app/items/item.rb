class Item
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActionView::Helpers::UrlHelper

  attr_accessor :description
  attr_accessor :due_at, :completed_at
  attr_accessor :image

  attr_accessor :editable

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
    description || type
  end

  def type
    model_name.name
  end

  def icon
    Icon.for(type) || Icon.circle
  end

  def timestamp
    return nil if completed_at.blank? && due_at.blank?
    DateTime.parse(completed_at || due_at)
  end

  def weekday
    timestamp ? timestamp.strftime("%a") : nil
  end

  def time_or_date
    return nil unless timestamp

    today = Date.today
    is_this_week = timestamp.between?(today.beginning_of_week, today.end_of_week)

    if is_this_week
      timestamp.strftime("%-I%P") # 2pm
    else
      timestamp.strftime("%F") # 1999-01-01
      #timestamp.strftime("%a") # Sat
    end
  end

  def relative_time
    date = timestamp&.to_date || Date.today # TODO: better default?
    today = Date.today
    last_week = today.beginning_of_week - 1
    last_month = today.beginning_of_month - 1

    if today < date
      "future"
    elsif today == date
      "today"
    elsif (today - 1) == date
      "yesterday"
    elsif today.all_week.cover?(date)
      "this week"
    elsif last_week.all_week.cover?(date)
      "last week"
    elsif today.all_month.cover?(date)
      "this month"
    elsif last_month.all_month.cover?(date)
      "last month"
    else
      date.strftime("%B %Y")
    end
  end

  def self.editable
    item = self.new
    item.editable = true
    item
  end
end
