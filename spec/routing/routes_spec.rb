RSpec.describe "routes" do
  it "defaults to the dashboard" do
    expect(:get => "/").to route_to(:controller => "dashboard", :action => "index")
  end

  it "to the /timeline page" do
    expect(:get => "/timeline").to route_to(:controller => "dashboard", :action => "timeline")
  end

  it "to the /goals page" do
    expect(:get => "/goals").to route_to(:controller => "dashboard", :action => "goals")
  end

  it "to the /pomodoros page" do
    expect(:get => "/pomodoros").to route_to(:controller => "dashboard", :action => "pomodoros")
  end

  describe "dashboard" do
    it "defaults to the index page" do
      expect(:get => "/dashboard").to route_to(:controller => "dashboard", :action => "index")
    end
  end
end
