require 'rails_helper'

describe Card do
  it 'pass validation - Card' do
    card = Card.new(original_text: 'schwarz', translated_text: 'black', review_date: Date.today)
    expect(card).to be_valid
  end

  it 'not pass validation - equity of original and translated values - Card' do
    card = Card.new(original_text: 'schwarz', translated_text: 'SCHWARZ')
    expect(card).not_to be_valid
  end

  it 'not pass validation - emptiness of original or translated values - Card' do
    card = Card.new(original_text: '', translated_text: 'black')
    expect(card).not_to be_valid
    card = Card.new(original_text: 'schwarz', translated_text: '')
    expect(card).not_to be_valid
  end
end
