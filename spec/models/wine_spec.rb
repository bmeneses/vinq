# == Schema Information
#
# Table name: wines
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  url                  :string(255)
#  wine_type            :string(255)
#  year                 :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime     ]   not null
#  appellation_id       :integer
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

    wine.create_appellation(name: "Barossa Valley",
                            url: "http://www.google.com")

    wine.appellation.create_region(id: 555,
                                 name: "Australia",
                                 url: "http://www.wine.com.au/")

    wine.appellation.region.create_area(id: 999,
                                      name: "Southern Hemisphere",
                                      url: "http://www.someurl.com")

    wine.product_attributes.build(id: 123456,
                                  name: "Spicy",
                                  url: "http://www.google.com")


  end

  subject { wine }

  # general

  it_behaves_like "a general_attribute"

  # fields

  it { should respond_to(:wine_type) }
  it { should respond_to(:year) }

  # associations

  it { should respond_to(:appellation) }
  it { should respond_to(:region) }
  it { should respond_to(:area) }
  it { should respond_to(:product_attributes) }

  its(:appellation) { should_not be_nil }
  its(:region) { should_not be_nil }
  its(:area) { should_not be_nil }

  # helper tests

  describe "when wine_type is not present" do
    before { wine.wine_type = " " }
    it { should_not be_valid }
  end

  # describe "when year is not present" do
  #   before { wine.year = " " }
  #   it { should_not be_valid }
  # end

  # describe "year must be numeric" do
  #   before { wine.year = "abc123" }
  #   it { should_not be_valid }
  # end

  # describe "year must less than or equal to today's year" do
  #   before { wine.year = Time.now.year + 1 }
  #   it { should_not be_valid }
  # end


  # method tests
  describe "#label" do
    before { @label = wine.label(:thumb) }
    it "should return a url " do
      @label.should be =~ /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
    end

  end

  describe "when saving with an appellation with region" do
    before do
     @wine = FactoryGirl.create(:wine)
     @wine.create_appellation(id: 123, name: "test", url:"http://www.google.com")
     @wine.appellation.create_region(id: 520, name: "blah",
                                     url: "http://www.google.com")
     @wine.save
    end

    it "should have region_id automatically populated" do
      @wine.region_id.should == @wine.appellation.region.id
    end

  end


end
