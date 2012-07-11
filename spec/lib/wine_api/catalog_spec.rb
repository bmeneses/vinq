require 'spec_helper'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :fakeweb
end

describe WineApi::Catalog do

  api_key = 'd416c704b94a08167684e8f5d1d7e987'

  it { should respond_to(:get) }

  let(:wine_api) { WineApi::Catalog.new }

  subject { wine_api }

  describe "when searching for categories" do
    before do 
      VCR.use_cassette('wine_api_catalog') do 
        @response = wine_api.get(categories: "490+124", 
                                    api_key: api_key)
      end
    end
    specify { @response.class.should be == Hashie::Mash }
    specify { @response.Status.ReturnCode.should be == 0 }
  end

  describe "when using offset" do 
    before do 
      VCR.use_cassette('wine_api_catalog_with_offset') do 
        @response = wine_api.get(categories: "490+124", 
                                     offset: 101,
                                    api_key: api_key)
      end
    end
    specify { @response.class.should be == Hashie::Mash }
    specify { @response.Status.ReturnCode.should be == 0 }
    specify { @response.Products.Offset.should be == 101 }
  end


  describe "when searching for product ids" do
    before do 
      VCR.use_cassette('wine_api_catalog_product') do 
        @response = wine_api.get(product_id: 103159, 
                                    api_key: api_key)
      end
    end
    specify { @response.class.should be == Hashie::Mash }
    specify { @response.Status.ReturnCode.should be == 0 }
    specify { @response.Products.Total.should be == 1 }
    specify { @response.Products.List[0].Id.should be == 103159 }
  end




end