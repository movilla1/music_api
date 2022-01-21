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
require 'rails_helper'

RSpec.describe Song, type: :model do
  describe "validations" do
    let(:song) { build(:song) }

    it "factory creates a valid object" do
      expect(song).to be_valid
    end

    it "doesn't validate songs with no name" do
      song.name = nil
      expect(song).not_to be_valid
    end

    it "doesn't validate songs with duration = 0" do
      song.duration = 0
      expect(song).not_to be_valid
    end

    it "doesn't validate songs with duration < 0" do
      song.duration = -10
      expect(song).not_to be_valid
    end

    it "doesn't validate songs that last 24hs" do
      song.duration = 86400
      expect(song).not_to be_valid
    end
  end
end
