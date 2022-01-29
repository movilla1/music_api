# frozen_string_literal: true

# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  album_art  :string
#  name       :string
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
include ActionDispatch::TestProcess

FactoryBot.define do
  factory :album do
    name { Faker::Ancient.hero }
    year { Time.current.year }
    album_art { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/album_art.jpg')) }
  end
end
