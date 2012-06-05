require 'spec_helper'

describe Appelation do

  let(:appelation) { FactoryGirl.create(:appelation) }

  subject { appelation }

  it { should respond_to(:appelation_id) }
  it { should respond_to(:name) }
  it { should respond_to(:url) }

  describe "when appelation_id is not present" do
    before { appelation.appelation_id = " " }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { appelation.name = " " }
    it { should_not be_valid }
  end

  describe "when url is not present" do
    before { appelation.url = " " }
    it { should_not be_valid }
  end

  describe "when URLs are the right format" do
    before do
      valid_url = "http://www.appelation.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
      appelation.url = valid_url
    end
    it { should be_valid }
  end


  describe "url is not the right format" do
    before { appelation.url = "http:/blah" }
    it { should_not be_valid }
  end

end
