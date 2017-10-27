RSpec.describe Item do
  before(:each) do
    fake_today = Date.parse("1999-05-26") # Saturday
    allow(Date).to receive(:today).and_return(fake_today)
  end

  it "displays the description given" do
    item = Item.new("my item")
    expect(item.display).to eq("my item")
  end

  context "#time_or_date" do
    it "shows just the time for things this week" do
      item = Item.new("my item", when: "1999-05-25 01:01 -0700")
      expect(item.time_or_date).to eq("1am")
    end

    it "shows just the date for things past this week" do
      item = Item.new("my item", when: "1998-01-01 01:01 -0700")
      expect(item.time_or_date).to eq("1998-01-01")
    end

    it "return nil if there is no timestamp set" do
      item = Item.new("my item")
      expect(item.time_or_date).to be_nil
    end
  end

  context "relative_time" do
    context "with a midnight cutoff" do
      it "shows 'future'" do
        item = Item.new("my item", when: "1999-05-27")
        expect(item.relative_time).to eq("future")
      end

      it "shows 'today'" do
        item = Item.new("my item", when: "1999-05-26")
        expect(item.relative_time).to eq("today")
      end

      it "shows 'yesterday'" do
        item = Item.new("my item", when: "1999-05-25")
        expect(item.relative_time).to eq("yesterday")
      end

      it "shows 'this week'" do
        item = Item.new("my item", when: "1999-05-24")
        expect(item.relative_time).to eq("this week")
      end

      it "shows 'last week'" do
        item = Item.new("my item", when: "1999-05-17")
        expect(item.relative_time).to eq("last week")
      end

      it "shows 'this month'" do
        item = Item.new("my item", when: "1999-05-10")
        expect(item.relative_time).to eq("this month")
      end

      it "shows 'last month'" do
        item = Item.new("my item", when: "1999-04-01")
        expect(item.relative_time).to eq("last month")
      end

      it "shows month & year for 2+ months ago " do
        item = Item.new("my item", when: "1999-03-30")
        expect(item.relative_time).to eq("March 1999")
      end
    end
  end
end
