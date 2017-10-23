RSpec.describe Item do
  it "displays the description given" do
    item = Item.new("my item")
    expect(item.display).to eq("my item")
  end

  context "#relative_time" do
    before(:each) do
      fake_today = DateTime.parse("1999-01-02 03:04:05 -0700") # Saturday
      allow(Date).to receive(:today).and_return(fake_today)
    end

    it "shows just the time for things this week" do
      item = Item.new("my item", when: "1999-01-01 01:01 -0700")
      expect(item.relative_time).to eq("1am")
    end

    it "shows just the date for things past this week" do
      item = Item.new("my item", when: "1998-01-01 01:01 -0700")
      expect(item.relative_time).to eq("1998-01-01")
    end

    it "return nil if there is no timestamp set" do
      item = Item.new("my item")
      expect(item.relative_time).to be_nil
    end
  end
end
