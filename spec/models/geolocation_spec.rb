# == Schema Information
#
# Table name: geolocations
#
#  id         :integer         not null, primary key
#  lat        :float
#  long       :float
#  url        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Geolocation do

  let(:geocode) { FactoryGirl.create(:geolocation) } 

  subject { geocode }

  describe "its lat value must be present" do
    before { geocode.lat = nil }
    it { should_not be_valid }
  end

  describe "its long value must be present" do
    before { geocode.lat = nil }
    it { should_not be_valid }
  end

  # describe "its long value must validate it is between -180 and +180" do
  #   before { geocode.lat = -180 }
  #   it { should_not be_valid }
  # end

  describe "when URLs are the right format" do
    before do
      valid_url = "http://www.appelation.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
      geocode.url = valid_url
    end
    it { should be_valid }
  end

  describe "url is not the right format" do
    before { geocode.url = "http:/blah" }
    it { should_not be_valid }
  end

end

