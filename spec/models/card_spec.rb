require 'rails_helper'

describe Card do
  before do
    @deck = FactoryGirl.create(:deck)
  end

  it 'pass validation - Card' do
    card = Card.new(original_text: 'schwarz', translated_text: 'black', review_date: Date.today, deck_id: @deck.id)
    expect(card).to be_valid
  end

  it 'not pass validation - equity of original and translated values - Card' do
    card = Card.new(original_text: 'schwarz', translated_text: 'SCHWARZ', review_date: Date.today, deck_id: @deck.id)
    expect(card).not_to be_valid
  end

  it 'not pass validation - emptiness of original or translated values - Card' do
    card = Card.new(original_text: '', translated_text: 'black', review_date: Date.today, deck_id: @deck.id)
    expect(card).not_to be_valid
    card = Card.new(original_text: 'schwarz', translated_text: '', review_date: Date.today, deck_id: @deck.id)
    expect(card).not_to be_valid
  end

  it 'Change rating after correct answer' do
    card = Card.new(original_text: 'schwarz', translated_text: 'black', review_date: Date.today, deck_id: @deck.id, rating: 1)
    interactor = CheckAnswer.call(card: card, answer: 'schwarz')
    expect(card.efactor).to eq(2.5)
  end

  it 'drop rating after three incorrect answers in a row' do
    card = Card.new(original_text: 'schwarz', translated_text: 'black', review_date: Date.today, deck_id: @deck.id, rating: 12)
    interactor = CheckAnswer.call(card: card, answer: 'grun')
    interactor = CheckAnswer.call(card: card, answer: 'rot')
    interactor = CheckAnswer.call(card: card, answer: 'gelb')
    expect(card.efactor).to eq(1.3)
  end
end
