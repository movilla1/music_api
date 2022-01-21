# frozen_string_literal: true

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
class Song < ApplicationRecord
  HALF_A_DAY_DURATION = 24300

  validates :title, presence: true, length: { minimum: 2 }
  validates :duration, presence: true, numericality: { minimum: 1, maximum: HALF_A_DAY_DURATION }

end
