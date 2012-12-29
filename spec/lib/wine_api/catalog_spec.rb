require 'spec_helper'



describe WineApi::Catalog do

  it { should respond_to(:get) }

  let(:catalog) { WineApi::Catalog.new }

  subject { catalog }

  describe "when searching for categories" do
    before do
      VCR.use_cassette('wine_api_catalog') do
        @response = catalog.get(categories: "490+124")
      end
    end


    specify { @response.should be_a Hashie::Mash }

    it "should return at least one product" do
      catalog.products.count.should be > 0
    end

  end

  describe "#get with offset" do
    before do
      VCR.use_cassette('wine_api_catalog_with_offset') do
        @response = catalog.get(categories: "490+124",
                                     offset: 101)
      end
    end

    specify { @response.should be_a Hashie::Mash }
    its(:return_code) { should be == 0 }

    it "its listing should start at the offset" do
      catalog.offset.should be == 101
    end


  end



  describe "#get with limit" do
    before do
      VCR.use_cassette('wine_api_catalog_limit', record: :new_episodes) do
        @response = catalog.get(categories: "490", limit: 1)
      end
    end
    it "should return a limited number of records" do
      catalog.products.count.should be == 1
    end
  end



  describe "when searching for product ids" do
    before do
      VCR.use_cassette('wine_api_catalog_product') do
        @response = catalog.get(product_id: 103159)
      end
    end

    specify { @response.should be_a Hashie::Mash }
    its(:return_code) { should be == 0 }

    it "should pull the correct product" do
      catalog.products[0].Id.should be == 103159
    end

    it "should only return one product" do
      catalog.products.count.should be == 1
    end


  end





end
