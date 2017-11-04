RSpec.describe "the dashboard" do
  it "shows this week and future" do
    visit "/"
    expect(page).to have_css("nav .current", text: "Present")
  end

  it "shows this week and future" do
    visit "/dashboard"
    expect(page).to have_css("nav .current", text: "Present")
  end

  it "shows past timeline" do
    visit "/timeline"
    expect(page).to have_css("nav .current", text: "Past")
  end

  it "shows future goals" do
    visit "/goals"
    expect(page).to have_css("nav .current", text: "Future")
  end

  it "shows pomodoro tracking" do
    visit "/pomodoros"
    expect(page).to have_css("nav .current", text: "Pomodoros")
  end
end
