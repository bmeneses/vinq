require File.dirname(__FILE__) + "/../../../app/models/wine"
require File.dirname(__FILE__) + "/../../../app/models/product_attribute"
require 'spec_helper'


describe WineApiDownloader::ProductDownloader do 

	VCR.configure do |c|
	  c.cassette_library_dir = 'fixtures/vcr_cassettes'
	  c.hook_into :fakeweb
	  c.default_cassette_options = { 
	    :re_record_interval => 1.year, 
	    :serialize_with => :json
	  }
	end

	let(:downloader) { WineApiDownloader::ProductDownloader.new }

	subject { downloader }

	describe "#save_category_products" do
		before(:all) do
			DatabaseCleaner.start
		 	VCR.use_cassette('wine_api_downloader_get_products', record: :new_episodes) do 
		  	downloader.save_category_products('144', 1)          
		  end
		end

		after(:all) do
			DatabaseCleaner.clean
		end

		it "should create 100 items in wines" do
			Wine.all.count.should == 100
		end

		it "should create 8 attributes" do
			ProductAttribute.all.count.should == 8
		end

		it "should create 20 appellations" do
			Appellation.all.count.should == 20
		end

		it "should create 6 regions" do
			Region.all.count.should == 6
		end

		it "should create 0 areas" do
			Area.all.count.should == 0
		end
	end

	describe "#get_single_product" do
		
	end

end

