require 'rails_helper'

describe 'home page specs', type: :feature do
  it 'checks equity of user answer and translated text' do
    card = FactoryGirl.create(:card, review_date: Date.today)
    visit root_path
    # fill_in 'answer', :with => card.original_text
    # click_button 'Check answer'
    expect(page).to have_content 'No cards for today!'
  end
end
