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

    Card.create(original_text: original_word, translated_text: translated_word, review_date: Date.today)
  end
end

def all_pages
  path_begin = 'http://www.languagedaily.com/learn-german/vocabulary/common-german-words'

  one_page(path_begin)

  for i in 3..12 do
    full_path = path_begin + '-' + i.to_s
    one_page(full_path)
  end
end

all_pages