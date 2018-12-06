data = Parser.parsing_page

data.each do |original_text, translated_text|
  Card.create(original_text: original_text, translated_text: translated_text)
end
