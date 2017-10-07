RSpec.describe "routes" do
  it "defaults to the dashboard" do
    expect(:get => "/").to route_to(:controller => "dashboard", :action => "index")
  end

  describe "dashboard" do
    it "defaults to the index page" do
      expect(:get => "/dashboard").to route_to(:controller => "dashboard", :action => "index")
    end
  end
end
