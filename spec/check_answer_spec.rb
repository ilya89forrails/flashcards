require 'rails_helper'

describe CheckAnswer do
  it 'pass - equity of user answer and translated text - CheckAnswer' do
    @card = Card.new(original_text: 'schwarz', translated_text: 'black', review_date: Date.today)
    user_answer = 'schwarz'
    interactor = CheckAnswer.call(card: @card, answer: user_answer)
    expect(interactor).to be_a_success
  end
end
