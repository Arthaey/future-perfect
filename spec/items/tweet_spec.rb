RSpec.describe Tweet do
  it "treats non-URL as tweet text" do
    tweet = Tweet.new("tweet tweet!")
    expect(tweet.display).to eq("tweet tweet!")
  end

  it "gets info from Twitter" do
    url = "https://twitter.com/arthaey/status/920298884219387905"
    tweet = Tweet.new(url)

    expect(tweet.display).to have_tag(".source a", href: url)
    expect(tweet.display).to have_tag(".username", text: "@arthaey")
    expect(tweet.display).to have_tag(".text", text: "\"Become a morning person\" is way too far for me personally, but I've become able to get up consistently despite being a night owl. :P")
  end
end
