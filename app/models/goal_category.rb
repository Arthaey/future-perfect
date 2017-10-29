class GoalCategory
  attr_accessor :name, :abbrev

  def initialize(name, abbrev = nil)
    @name = name
    @abbrev = abbrev || name[0..1]
  end

  def to_s
    name
  end

  @@all = {
    marriage:   GoalCategory.new("Marriage"),
    career:     GoalCategory.new("Career"),
    health:     GoalCategory.new("Health"),
    adulting:   GoalCategory.new("Adulting", "Adlt"),
    money:      GoalCategory.new("Money"),
    relaxing:   GoalCategory.new("Relaxing"),
    language:   GoalCategory.new("Language"),
    creativity: GoalCategory.new("Creativity"),
    friends:    GoalCategory.new("Friends"),
    adventure:  GoalCategory.new("Adventure", "Adv"),
  }

  def self.each(&block)
    @@all.values.each(&block)
  end

  def self.[](sym)
    @@all[sym]
  end
end
