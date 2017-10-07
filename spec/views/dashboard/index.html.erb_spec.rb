RSpec.describe "dashboard/index.html.erb", type: :view do
  it "displays" do
    render
    expect(rendered).to match(/Dashboard/)
  end
end
