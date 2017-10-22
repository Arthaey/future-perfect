RSpec.describe "routes" do
  it "defaults to the dashboard" do
    expect(:get => "/").to route_to(:controller => "dashboard", :action => "index")
  end

  it "to the /timeline page" do
    expect(:get => "/timeline").to route_to(:controller => "dashboard", :action => "timeline")
  end

  it "to the /styleguide page" do
    expect(:get => "/styleguide").to route_to(:controller => "dashboard", :action => "styleguide")
  end

  describe "dashboard" do
    it "defaults to the index page" do
      expect(:get => "/dashboard").to route_to(:controller => "dashboard", :action => "index")
    end
  end
end
