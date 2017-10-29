RSpec.describe "dashboard/index.html.erb", type: :view do
  it "displays" do
    assign(:past, [])
    render
    expect(rendered).to have_css(".items")
  end
end
