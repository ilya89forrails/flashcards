require 'rails_helper'

describe 'home page specs', type: :feature do
  before do
    @user = FactoryGirl.create(:user)
    visit login_path
    fill_in('email', with: 'user@server.com')
    fill_in('password', with: 'pass')
    click_button('Login')
  end

  it 'checks equity of user answer and translated text' do
    card = FactoryGirl.create(:card, user_id: @user.id, review_date: Date.today)
    visit root_path
    # fill_in('answer', with: 'schwarz')
    # click_button 'Check answer'
    # expect(page).to have_content 'You are right!'
    expect(page).to have_content 'No cards for today!'
  end
end
