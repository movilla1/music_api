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
