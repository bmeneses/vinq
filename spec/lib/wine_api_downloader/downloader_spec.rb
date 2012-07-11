require 'spec_helper'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :fakeweb
end

# # describe WineApiDownloader::Downloader do

# #   api_key = 'd416c704b94a08167684e8f5d1d7e987'

# #   let(:downloader) { WineApiDownloader::WineApiDownloader.new }

# #   subject { downloader }

# #   describe "when downloading products" do
#     before do
#       VCR.use_cassette('wine_api_downloader_get_products') do 
#         downloader.get_products
#         @response = category.get(categories: "490", api_key: api_key)
#       end
#     end

# #   end



# end
