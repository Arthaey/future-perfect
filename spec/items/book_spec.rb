RSpec.describe Book do
  it "treats non-URL as book title" do
    book = Book.new("War & Peace")
    expect(book.display).to eq("“War & Peace”")
  end
end
