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
		before do
			VCR.use_cassette('wine_api_prod_downloader', record: :new_episodes) do 
				downloader.save_product_by_id('103159')
			end
		end

		it "should populate wines with a single item" do
			Wine.all.count.should == 1
			Wine.first.id.should == 103159
			ProductAttribute.all.count.should == 4
			Appellation.all.count.should == 1
			Region.all.count.should == 1
			Area.all.count.should == 0
		end
	end

	describe "a wine's appellation already exists" do
		before do
			VCR.use_cassette('wine_api_prod_downloader', record: :new_episodes) do 
				downloader.save_product_by_id('103159')
				downloader.save_product_by_id('114718')
			end
		end

		it "should create an appellation for the first wine" do
			Wine.find_by_id(103159).appellation.should_not be nil
		end

		specify "and the second wine should have an appellation too" do
			Wine.find_by_id(114718).appellation.should_not be nil
		end

	end
end

