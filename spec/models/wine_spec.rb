# == Schema Information
#
# Table name: wines
#
#  id         :integer         not null, primary key
#  product_id :string(255)
#  name       :string(255)
#  url        :string(255)
#  type       :string(255)
#  year       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Wine do
  
  let(:wine) { Wine.new(product_id: "123456",
                        name: "Boozy Cabernet",
                        url: "http://boozy.com/product?459669",
                        type: "Cabernet Sauvignon",
                        year: "1996") } 
  subject { wine }

  it { should respond_to(:product_id) }
  it { should respond_to(:name) }
  it { should respond_to(:url) }
  it { should respond_to(:type) }
  it { should respond_to(:year) }

  describe "when product_id is not present" do
    before { wine.product_id = " " }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { wine.name = " " }
    it { should_not be_valid }
  end

  describe "when url is not present" do
    before { wine.url = " " }
    it { should_not be_valid }
  end

  describe "when URLs are the right format" do
    before do
      valid_url = "http://www.wine.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
      wine.url = valid_url
    end
    it { should be_valid }
  end


  describe "url is not the right format" do
    before { wine.url = "http:/blah" }
    it { should_not be_valid }
  end

  describe "when type is not present" do
    before { wine.type = " " }
    it { should_not be_valid }
  end

  describe "when year is not present" do
    before { wine.product_id = " " }
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
