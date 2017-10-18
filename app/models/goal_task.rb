GoalTask = Struct.new(:description, :goal) do
  def category_name
    goal&.category&.name
  end

  def icon
    Icon.for_type(goal.category.name)
  end
end
