# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# ! /usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'json'
# require 'openssl'
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
# Fetch and parse HTML document
doc = Nokogiri::HTML(open('http://1000mostcommonwords.com/1000-most-common-german-words/'))

content = []

doc.xpath('//tr').each do |value|
  first_word = value.xpath('td[2]').text
  second_word = value.xpath('td[3]').text
  content.push([
                 first_word,
                 second_word
               ])
end

content.each do |first, second|
  Card.create(original_text: first, translated_text: second)
end
