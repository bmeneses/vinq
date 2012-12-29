require 'spec_helper'

describe WineApi::Category do

  # TODO: remove api key

  it { should respond_to(:get) }

  let(:category) { WineApi::Category.new }

  subject { category }

  describe "when downloading categories" do
    before do
      VCR.use_cassette('wine_api_category') do
        @response = category.get
      end
    end
    specify { @response.should be_an Array }
    # specify { @response.should include({  "Id" => 139,
    #                                     "Name" => "Cabernet Sauvignon",
    #                                      "Url" => "" }) }
  specify { @response.should include({  "Id" => 124,
                                        "Name" => "Red Wine",
                                         "Url" => "" }) }
  end


end
