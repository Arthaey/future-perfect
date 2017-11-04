class DashboardController < ApplicationController
  include PrototypeDataHelper

  def index
    @items_by_time = items_by_time()
    @today_weekday = today_weekday()
    @items_by_weekday= items_by_weekday
    @todos = todos()
  end

  def timeline
    @items_by_date = items_by_date()
  end

  def goals
    @items_by_category = items_by_category()
    @category_abbrevs = category_abbrevs()
    @category_classes = category_classes()
  end

  def pomodoros
    @pomodoro_items = pomodoro_items()
  end
end
