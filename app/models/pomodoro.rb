class Pomodoro
  include ActiveModel::Model
  extend ActiveModel::Naming

  attr_accessor :items
  attr_accessor :state, :duration

  def initialize(*items)
    @items = items
    @state = :unstarted
  end

  def duration
    return nil unless @duration
    minutes = @duration.value / 60.0
    "#{minutes.round}m" if @duration
  end

  def start
    @state = :active
    self
  end

  def finish
    @state = :completed
    self
  end

  def self.start(*items)
    pomodoro = Pomodoro.new(*items)
    pomodoro.start()
  end

  def self.done(*items, **attrs)
    pomodoro = Pomodoro.new(*items)
    pomodoro.duration = attrs[:in]
    pomodoro.finish()
  end
end