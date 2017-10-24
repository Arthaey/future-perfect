RSpec.describe "the dashboard" do
  it "shows this week and future" do
    visit "/dashboard"
    expect(page).to have_css("nav .current", text: "Present & Future")
  end

  it "shows past timeline" do
    visit "/timeline"
    expect(page).to have_css("nav .current", text: "Past")
  end
end
