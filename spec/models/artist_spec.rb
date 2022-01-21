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
require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "validations" do
    let(:artist) { build(:artist) }

    it "doesn't validate empty names" do
      artist.name = nil
      expect(artist).not_to be_valid
    end
  end
end
