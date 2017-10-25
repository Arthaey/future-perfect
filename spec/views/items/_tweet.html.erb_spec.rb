RSpec.describe "tweet partial" do
  let(:url) { "https://twitter.com/arthaey/status/920298884219387905" }
  let(:username) { "arthaey" }
  let(:text) { "\"Become a morning person\" is way too far for me personally, but I've become able to get up consistently despite being a night owl. :P" }

  it "displays the text, username, and source url" do
    tweet = Tweet.new(text, username: username, source_url: URI.parse(url))
    render(partial: "items/tweet", object: tweet)

    expect(rendered).to have_tag(".text", text: text)
    expect(rendered).to have_tag(".username", text: "@#{username}")
    expect(rendered).to have_tag(".source a", href: url)
  end

  it "displays just the text" do
    tweet = Tweet.new(text)
    render(partial: "items/tweet", object: tweet)

    expect(rendered).to have_tag(".text", text: text)
    expect(rendered).not_to have_tag(".username")
    expect(rendered).not_to have_tag(".source a")
  end

  it "displays just the source url" do
    tweet = Tweet.new(nil, source_url: URI.parse(url))
    render(partial: "items/tweet", object: tweet)

    expect(rendered).not_to have_tag(".text")
    expect(rendered).not_to have_tag(".username")
    expect(rendered).to have_tag(".source a", href: url)
  end

  it "displays the text and source url" do
    tweet = Tweet.new(text, source_url: URI.parse(url))
    render(partial: "items/tweet", object: tweet)

    expect(rendered).to have_tag(".text", text: text)
    expect(rendered).not_to have_tag(".username")
    expect(rendered).to have_tag(".source a", href: url)
  end

  it "displays the text and username" do
    tweet = Tweet.new(text, username: username)
    render(partial: "items/tweet", object: tweet)

    expect(rendered).to have_tag(".text", text: text)
    expect(rendered).to have_tag(".username", text: "@#{username}")
    expect(rendered).not_to have_tag(".source a")
  end
end
