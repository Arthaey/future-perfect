class Appointment < Item
  def default_category
    GoalCategory[:adulting]
  end
end
