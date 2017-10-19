GoalTask = Struct.new(:description, :goal) do
  def category_name
    goal&.category&.name
  end

  def icon
    Icon.send(goal.category.name)
  end
end
