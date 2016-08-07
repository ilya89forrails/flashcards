FactoryGirl.define do
  factory :user do
    email 'user@server.com'
    password 'pass'
    password_confirmation 'pass'
  end
end
