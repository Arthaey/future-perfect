# HARDCODED PROTOTYPE DATA #####################################################
module PrototypeDataHelper

  def pomodoro_items
    book = Book.new("https://www.goodreads.com/book/show/656", when: "2017-10-10")

    minimum_pomodoros = 8 # arbitrary target

    pomodoros = [
      Pomodoro.stop(book, in: 20.minutes),
      Pomodoro.start(Fun.new("went to a new cafe with some folks")),
      Pomodoro.new(Appointment.new("Foo"), Task.new("Bar"), Task.new("Qux")),
    ]

    while pomodoros.count < minimum_pomodoros
      pomodoros.push(Pomodoro.new())
    end

    {
      soon: pomodoros.select(&:unstarted?),
      now:  pomodoros.select(&:started?),
      done: pomodoros.select(&:stopped?),
    }
  end


  def items_by_date
    past = [
      Task.new("trimmed plants in the front yard", when: "2017-10-14"),
      Task.new("entered receipts into YNAB", when: "2017-10-13"),
      Task.new("made car care checklist for Acura", when: "2017-10-15"),
      Tweet.new("https://twitter.com/arthaey/status/920298884219387905", when: "2017-10-17"),
      Book.new("https://www.goodreads.com/book/show/656", when: "2017-10-10"),
      Book.new("https://www.amazon.com/dp/1400079985/", when: "2017-10-10"),
      Item.new("generic drawing", image: "drawing.jpg"),
      Ocr.new("OCR would be cool", image: "ocr.jpg"),
      Appointment.new("an appointment", when: "2017-09-23"),
    ]

    undated, dated = past.partition { |item| item.timestamp.nil? }
    dated = dated.sort_by!(&:timestamp).reverse.group_by(&:relative_time)
    dated.merge({ "undated": undated })
  end

  def items_by_weekday
    present = [
      Fun.new("arcade & Olive Garden", when: "2017-10-16 18:00 -0700"),
      Appointment.new("something else that takes up two lines", when: "2017-10-18 19:00 -0700"),
      Appointment.new("an appointment", when: "2017-10-18 18:00 -0700"),
      Appointment.new("other appointment", when: "2017-10-19 19:00 -0700"),
    ]

    weekdays = %w(Mon Tue Wed Thu Fri Sat Sun)

    by_weekday = {}
    weekdays.each { |day| by_weekday[day] = [] }
    by_weekday.merge!(present.group_by(&:weekday))
  end

  def items_by_category
    items = [
      Task.new("enter receipts", category: GoalCategory[:money])
    ]

    no_cat, has_cat = items.partition { |item| item.category.nil? }

    items_by_category = {}
    GoalCategory.each { |cat| items_by_category[cat] = [] }
    items_by_category.merge!(has_cat.group_by(&:category))
  end

  def category_abbrevs
    category_abbrevs = {}
    GoalCategory.each { |cat| category_abbrevs[cat] = cat.abbrev }
    category_abbrevs
  end


  def category_classes
    category_classes = {}
    GoalCategory.each { |cat| category_classes[cat] = "cat-#{cat}" }
    category_classes
  end

  def todos
    [
      Book.new("Some Book"),
    ]
  end

end
# END HARDCODED DATA ###########################################################
