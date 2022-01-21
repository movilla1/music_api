# frozen_string_literal: true

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
class Song < ApplicationRecord
  HALF_A_DAY_DURATION = 24300

  validates :name, presence: true, length: { minimum: 2 }
  validates :duration, presence: true, numericality: { greater_than: 0, less_than: HALF_A_DAY_DURATION }
  enum genre: {
    rock: 1, pop: 2,
    funk: 3, reggae: 4,
    classical: 5, country: 6,
    jazz: 7
  }

end
