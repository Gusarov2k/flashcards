require 'nokogiri'
require 'open-uri'

module Parser
  def self.parsing_page
    doc = Nokogiri::HTML(open('http://1000mostcommonwords.com/1000-most-common-german-words/'))
    doc.xpath('//tr').each_with_object([]) do |value, arr|
      arr.push([
                 value.xpath('td[2]').text,
                 value.xpath('td[3]').text
               ])
    end
  end
end
