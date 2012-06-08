# == Schema Information
#
# Table name: areas
#
#  id         :integer         not null, primary key
#  area_id    :integer
#  name       :string(255)
#  url        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Area do

  let(:wine) { FactoryGirl.create(:wine) }

  before do
    wine.build_appelation(appelation_id: "123",
                          name: "Barossa Valley",
                          url: "http://www.google.com")
    
    wine.appelation.build_region(region_id: "555",
                                 name: "Australia",
                                 url: "http://www.wine.com.au/")

    wine.appelation.region.build_area(area_id: "999",
                                      name: "Southern Hemisphere",
                                      url: "http://www.someurl.com")
  end

  subject { wine.appelation.region.area }

  it { should respond_to(:area_id) }
  it { should respond_to(:name) }
  it { should respond_to(:url) }

  describe "when area_id is not present" do
    before { wine.appelation.region.area.area_id = " " }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { wine.appelation.region.area.name = " " }
    it { should_not be_valid }
  end

  describe "when url is not present" do
    before { wine.appelation.region.area.url = " " }
    it { should_not be_valid }
  end

  describe "when URLs are the right format" do
    before do
      valid_url = "http://www.appelation.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
      wine.appelation.region.area.url = valid_url
    end
    it { should be_valid }
  end

  describe "url is not the right format" do
    before { wine.appelation.region.area.url = "http:/blah" }
    it { should_not be_valid }
  end

  describe "when area_id is not unique" do
    before do
      other_region = wine.appelation.region.area.dup
      other_region.save
    end

    it { should_not be_valid }

  end
end

#

