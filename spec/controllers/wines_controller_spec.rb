require 'spec_helper'

describe WinesController do
	describe "#index" do
		context "with parameters" do 
			[:region, :appellation, :varietal, :product_attributes].each do |type|
				it "saves the #{type} parameter in the session hash" do
					get :index, { type => '1' }
					session[:wine_index_filters][type].should eq('1')
				end
			end
		end
	end
end
