Event = Struct.new(:type, :timestamp, :description) do

  def time
    DateTime.parse(timestamp).strftime("%-I%P")
  end

  def weekday
    DateTime.parse(timestamp).strftime("%a")
  end

  def icon
    Icon.for_type(type)
  end

end
