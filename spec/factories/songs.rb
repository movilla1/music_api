# == Schema Information
#
# Table name: songs
#
#  id         :bigint           not null, primary key
#  duration   :integer
#  featured   :boolean
#  genre      :integer
#  name       :string
#  track_numb :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :song do
    name { Faker::FunnyName.name }
    duration { rand(240) }
    genre { %i[rock pop funk reggae classical country jazz].sample }
    track_numb { rand(33) + 1 }
    featured { false }

    trait :featured do
      featured { true }
    end
  end
end
