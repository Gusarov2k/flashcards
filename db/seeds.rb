# require '../lib/parser'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://1000mostcommonwords.com/1000-most-common-german-words/'))

content = doc.xpath('//tr').each_with_object([]) do |value, massiv|
  massiv.push([
                value.xpath('td[2]').text,
                value.xpath('td[3]').text
              ])
end

content.each do |original_text, translated_text|
  Card.create(original_text: original_text, translated_text: translated_text)
end
