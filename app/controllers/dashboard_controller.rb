class DashboardController < ApplicationController
  include PrototypeDataHelper

  def index
    @pomodoro_items = pomodoro_items()

    @today_weekday = Date.today.strftime("%a")
    @items_by_weekday= items_by_weekday

    @items_by_category = items_by_category()
    @category_abbrevs = category_abbrevs()
    @category_classes = category_classes()

    @todos = todos()
  end

  def timeline
    @items_by_date = items_by_date()
  end
end
