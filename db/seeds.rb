# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'nokogiri'
require 'open-uri'

def one_page(full_path)
  current_page = Nokogiri::HTML(open(full_path))

  current_page.css('tr').each do |word|
    original_word = word.css('td.bigLetter').text
    translated_word = word.css('td')[2].text
    Card.create(original_text: original_word, translated_text: translated_word, review_date: Date.today) unless translated_word.nil?
  end
end

def all_pages
  domain = 'http://www.languagedaily.com'
  pattern = 'http://www.languagedaily.com/learn-german/vocabulary/'
  first_page = Nokogiri::HTML(open(domain + '/learn-german/vocabulary/common-german-words'))
  all_links = []
  first_page.css('a').each do |link|
    full_path = domain + link['href'].to_s
    all_links.push(full_path) if full_path.include? pattern
  end
  all_links.first(12).each do |link|
    one_page(link)
  end
end

all_pages
