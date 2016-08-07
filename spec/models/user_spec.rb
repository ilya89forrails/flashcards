require 'rails_helper'

RSpec.describe User, type: :model do
  it 'pass validation - User' do
    user = User.new(email: 'name@server.com', password: 'password')
    expect(user).to be_valid
  end

  it 'not pass validation - email or password are empty - User' do
    user = User.new(email: '', password: 'password')
    expect(user).not_to be_valid
    user = User.new(email: 'name@server.com', password: '')
    expect(user).not_to be_valid
  end

  it 'not pass validation - email is not unique - User' do
    user = User.create(email: 'name@server.com', password: 'password')
    user2 = User.create(email: 'name@server.com', password: 'password2')
    expect(user2).not_to be_valid
  end
end
