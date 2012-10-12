require 'spec_helper'
require 'pry'

# describe "WinePages" do
#   describe "GET /wine_pages" do
#     it "works! (now write some real specs)" do
#       # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#       get wine_pages_index_path
#       response.status.should be(200)
#     end
#   end

describe "wine pages" do

	subject { page }

	describe "index" do
		before(:all) do 
			DatabaseCleaner.start
			20.times { FactoryGirl.create(:wine_complete) }
		end

		after(:all) do
			DatabaseCleaner.clean
		end


		describe "visiting index" do
			before { visit wines_path }
			it { should have_selector('title', text: 'Wine Listing') }
		end

		describe "with bad wines" do 
			describe "when appellation is nil" do	
				before do
					wine = Wine.first
					wine.appellation = nil
					wine.save
					visit wines_path
				end

				it { should have_content('(no appellation)') }
			end
		end
	end

end
