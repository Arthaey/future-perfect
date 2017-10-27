class Ocr < Item
  def display
    "<p>#{text_from_image}</p><p>#{@description}</p>".html_safe
  end

  def text_from_image
    "OCR of uploaded\nhandwritten stuff"
  end

  def lines
    text_from_image.split("\n")
  end
end
