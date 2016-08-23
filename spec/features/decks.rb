require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'

describe 'Decks', type: :feature do
  let!(:user) { create(:user) }

  before(:each) do
    login('q', 'q')
  end

  it 'Create new deck' do
    visit new_deck_path
    fill_in 'title', with: 'title'
    click_button 'Create Deck'
    expect(page).to have_content 'title'
  end

  it 'Select current deck' do
    visit decks_path
    click_link 'Make current'
    expect(page).to have_content 'Current deck title'
  end
end
