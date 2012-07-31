require File.dirname(__FILE__) + "/../../../app/models/wine"
require File.dirname(__FILE__) + "/../../../app/models/product_attribute"
require 'spec_helper'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :fakeweb
  c.default_cassette_options = { 
    :re_record_interval => 1.year, 
    :serialize_with => :json
  }
end

describe WineApiDownloader::Downloader do

  api_key = 'd416c704b94a08167684e8f5d1d7e987'

  let(:downloader) { WineApiDownloader::Downloader.new }
  let(:category)   { WineApi::Category.new }
  let(:catalog)    { WineApi::Catalog.new }
  #let(:wine_mock)  { FactoryGirl.create(:wine, 
   #                  product_attributes: [Factory.create(:product_attribute)]) }

  subject { downloader }

  describe "#get" do
    describe "with page limit" do
      before(:all) do
        #need to find a way to mock up some categories & products here
        # mock up data in the db somehow
       # wine_mock.save
       VCR.use_cassette('wine_api_downloader_get_products', record: :new_episodes) do 
        downloader.get_products(page_limit: 1)
          # @api_response = catalog.get(categories: "490", api_key: api_key)
          
        end
      end

      it "should create x items in product_attributes_wines table" do
         ProductAttribute.all.count.should == 13
      end

      #todo make this match the responses from the api
      it "should have 568 items" do
        Wine.all.count.should == 568
      end

      describe "varietals" do
        it "should create varietals/winetype assocations for a wine" do
          wine = Wine.first
          wine.varietal.should_not be_nil
        end

        it "should have 37 varietals in the db" do 
          Varietal.all.count.should == 37
        end
      end

      describe "appellations" do
        # it "should create appellations and parent appellations for a wine" do
        #   wine = Wine.first
        #   wine.appellation.should_not be_nil
        #   wine.appellation.region.should_not be_nil
        #   wine.appellation.region.area.should_not be_nil
        # end

        it "should have 37 varietals in the db" do 
          Appellation.all.count.should == 73
        end
      end


      
    end
  end
end


# context "internal methods" do
#   describe "#build_category_worklist" do
#     before do
#       downloader.build_category_worklist(

