require 'rails_helper'

describe 'Login/logout' do
  it 'User can login/logout' do
    @user = FactoryGirl.create(:user)
    visit login_path(locale: 'en')
    fill_in('email', with: 'user@server.com')
    fill_in('password', with: 'pass')
    click_button('Login')
    expect(page).to have_content 'My account'
    click_link('Sign out')
    expect(page).to have_content 'Sign in'
  end
end
