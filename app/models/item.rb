class Item
  include ActiveModel::Model
  extend ActiveModel::Naming

  attr_accessor :description
  attr_accessor :due_at, :completed_at

  def initialize params = {}
    params.each { |key, value| send "#{key}=", value }
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

  def time
    timestamp ? DateTime.parse(timestamp).strftime("%-I%P") : nil
  end

  def weekday
    timestamp ? DateTime.parse(timestamp).strftime("%a") : nil
  end
end
