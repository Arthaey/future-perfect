RSpec.describe Book do
  it "treats non-URL as book title" do
    book = Book.new("War & Peace")
    expect(book.display).to eq("“War & Peace”")
  end

  it "gets info from Goodreads" do
    book = Book.new("https://www.goodreads.com/book/show/656")
    expect(book.display).to eq("“War and Peace” by Leo Tolstoy")
  end

  it "gets info from Amazon" do
    book = Book.new("https://www.amazon.com/dp/1400079985/")
    expect(book.display).to eq("“War and Peace” by Leo Tolstoy")
  end
end
