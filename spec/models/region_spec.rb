require 'spec_helper'

describe Region do

  let(:wine) { FactoryGirl.create(:wine) }

  before { wine.region.build(region_id: "123",
                             name: "Australia",
                             url: "http://www.goodurl.com")}

  subject { wine.region }

  it { should respond_to(:region_id) }
  it { should respond_to(:name) }
  it { should respond_to(:url) }

  describe "when appelation_id is not present" do
    before { wine.region.region_id = " " }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { wine.region.name = " " }
    it { should_not be_valid }
  end

  describe "when url is not present" do
    before { wine.region.url = " " }
    it { should_not be_valid }
  end

  describe "when URLs are the right format" do
    before do
      valid_url = "http://www.appelation.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
      wine.region.url = valid_url
    end
    it { should be_valid }
  end


  describe "url is not the right format" do
    before { wine.region.url = "http:/blah" }
    it { should_not be_valid }
  end

end
