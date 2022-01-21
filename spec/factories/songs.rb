# == Schema Information
#
# Table name: songs
#
#  id         :bigint           not null, primary key
#  duration   :integer
#  featured   :boolean
#  genre      :string
#  name       :string
#  track_numb :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :song do
    name { Faker::Funny.name }
    duration { Math.rand(240) }
    genre { %w[Rock Pop Funk Reggae Classical Country Jazz].sample }
    track_numb { Math.rand(33) + 1 }
    featured { false }

    trait :featured do
      featured { true }
    end
  end
end
