Event = Struct.new(:type, :timestamp, :description) do

  def time
    timestamp ? DateTime.parse(timestamp).strftime("%-I%P") : nil
  end

  def weekday
    timestamp ? DateTime.parse(timestamp).strftime("%a") : nil
  end

  def icon
    Icon.for_type(type)
  end

end
