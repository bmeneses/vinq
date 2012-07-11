require 'spec_helper'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :fakeweb
end

describe WineApi::Category do

  api_key = 'd416c704b94a08167684e8f5d1d7e987'

  it { should respond_to(:get) }

  let(:category) { WineApi::Category.new }

  subject { category }

  describe "when downloading categories" do
    before do 
      VCR.use_cassette('wine_api_category') do 
        @response = category.get(categories: "490", api_key: api_key)
      end
    end
    specify { @response.should be_an Array }
    specify { @response.should include({  "Id" => 139, 
                                        "Name" => "Cabernet Sauvignon", 
                                         "Url" => "" }) } 
  end
end