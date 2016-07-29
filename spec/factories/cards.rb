require 'rails_helper'

FactoryGirl.define do
  factory :card do
    original_text 'schwarz'
    translated_text 'black'
  end
end