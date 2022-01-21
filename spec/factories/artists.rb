# frozen_string_literal: true

# == Schema Information
#
# Table name: artists
#
#  id         :bigint           not null, primary key
#  biography  :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :artist do
    name { Faker::Ancient.god }
    biography { Faker::Lorem.paragraph }
  end
end
