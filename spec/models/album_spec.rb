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
require 'rails_helper'

RSpec.describe Album, type: :model do
  describe "validations" do
    let(:album) { create(:album) }

    it "has a valid factory" do
      expect(album).to be_valid
    end

    it "doesn't validate with no name" do
      album.name = nil
      expect(album).not_to be_valid
    end
  end
end
