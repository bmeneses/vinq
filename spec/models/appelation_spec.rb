# == Schema Information
#
# Table name: appelations
#
#  id            :integer         not null, primary key
#  appelation_id :integer
#  name          :string(255)
#  url           :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  region_id     :integer
#

require 'spec_helper'

describe Appelation do

  let(:wine) { FactoryGirl.create(:wine) }

  before { wine.build_appelation(appelation_id: "123",
                                 name: "Barossa Valley",
                                 url: "http://www.google.com") }

  subject { wine.appelation }

  it { should respond_to(:appelation_id) }
  it { should respond_to(:name) }
  it { should respond_to(:url) }

  describe "when appelation_id is not present" do
    before { wine.appelation.appelation_id = " " }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { wine.appelation.name = " " }
    it { should_not be_valid }
  end

  describe "when url is not present" do
    before { wine.appelation.url = " " }
    it { should_not be_valid }
  end

  describe "when URLs are the right format" do
    before do
      valid_url = "http://www.appelation.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
      wine.appelation.url = valid_url
    end
    it { should be_valid }
  end


  describe "url is not the right format" do
    before { wine.appelation.url = "http:/blah" }
    it { should_not be_valid }
  end


  describe "when appelation_id is not unique" do
    before do
      other_appelation = wine.appelation.dup
      other_appelation.save
    end
    it { should_not be_valid }
  end

end

