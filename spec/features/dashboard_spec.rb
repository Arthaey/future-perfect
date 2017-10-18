RSpec.describe "the dashboard" do
  it "loads" do
    visit "/dashboard"
    expect(page).to have_content("Future Perfect")
  end
end
