# == Schema Information
#
# Table name: wines
#
#  id                   :integer         not null, primary key
#  wine_id              :string(255)
#  name                 :string(255)
#  url                  :string(255)
#  type                 :string(255)
#  year                 :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  appelation_id        :integer
#  varietal_id          :integer
#  price_min            :decimal(, )
#  price_max            :decimal(, )
#  price_retail         :decimal(, )
#  product_attribute_id :integer
#

require 'spec_helper'

describe Wine do
  
  let(:wine) { FactoryGirl.create(:wine) } 

  before do

    wine.create_appelation(appelation_id: "123",
                          name: "Barossa Valley",
                          url: "http://www.google.com")
    
    wine.appelation.create_region(region_id: "555",
                                 name: "Australia",
                                 url: "http://www.wine.com.au/")

    wine.appelation.region.create_area(area_id: "999",
                                      name: "Southern Hemisphere",
                                      url: "http://www.someurl.com")

    wine.product_attributes.build(product_attribute_id: 123456,
                                  name: "Spicy",
                                  url: "http://www.google.com")

  
  end

  subject { wine }

  # general

  it_behaves_like "a general_attribute"

  # fields

  it { should respond_to(:type) }
  it { should respond_to(:year) }

  # associations

  it { should respond_to(:appelation) }
  it { should respond_to(:region) }
  it { should respond_to(:area) }
  it { should respond_to(:product_attributes) }

  its(:appelation) { should_not be_nil }
  its(:region) { should_not be_nil }
  its(:area) { should_not be_nil }

  # helper tests

  describe "when type is not present" do
    before { wine.type = " " }
    it { should_not be_valid }
  end

  describe "when year is not present" do
    before { wine.year = " " }
    it { should_not be_valid }
  end

  describe "year must be numeric" do
    before { wine.year = "abc123" }
    it { should_not be_valid }
  end

  describe "year must less than or equal to today's year" do
    before { wine.year = Time.now.year + 1 }
    it { should_not be_valid }
  end

  

end