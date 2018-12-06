module Parser
  attr_accessor :content

  def parsing_page
    require 'nokogiri'
    require 'open-uri'

    doc = Nokogiri::HTML(open('http://1000mostcommonwords.com/1000-most-common-german-words/'))
    self.content = doc.xpath('//tr').each_with_object([]) do |value, massiv|
      massiv.push([
                    value.xpath('td[2]').text,
                    value.xpath('td[3]').text
                  ])
    end
  end
end
