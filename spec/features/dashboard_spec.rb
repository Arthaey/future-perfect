RSpec.describe "the dashboard" do
  it "shows this week and future" do
    visit "/dashboard"
    expect(page).to have_css("nav .current", text: "Present & Future")
  end

  it "shows past timeline" do
    visit "/timeline"
    expect(page).to have_css("nav .current", text: "Past")
  end

  it "shows the styleguide" do
    visit "/styleguide"
    expect(page).to have_css("h1", text: "Styleguide")
  end
end
