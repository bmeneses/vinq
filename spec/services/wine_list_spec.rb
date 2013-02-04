require 'spec_helper'

require File.dirname(__FILE__) + "/../../app/services/wine_list"

shared_examples_for "a wine list filter" do |type|
	its(:list) { should be_a_kind_of(ActiveRecord::Relation) }

	it "should only have wines that belong to the #{type} filter" do
		wine_list.list.should include(@one_wine)
		wine_list.list.should_not include(@another_wine)
	end

	it "should only have attributes that belong to the #{type} filter" do
		wine_list.attributes[type].should include(@test_attribute)
		wine_list.attributes[type].should_not include(@negative_attribute)
	end
end


describe WineList do

	let(:wine_list) { WineList.new }

	subject { wine_list }

	describe "#list" do 
		
		context "without parameters" do 
			before do 
				5.times { FactoryGirl.create(:wine_complete) }
				@response  = wine_list.get
			end

			specify { @response.should be_a_kind_of(ActiveRecord::Relation) }

			its(:list) { should be_a_kind_of(ActiveRecord::Relation) }

			it "should set its wines attr to all wines" do
				wine_list.list.count.should eq(5)
			end

			[:region, :appellation, :varietal].each do |type|
				it "should set its attributes hash to include all attributes for #{type}" do
					wine_list.attributes[type].count.should eq(5)
				end
			end

			it "should set its attributes hash to include all product_attributes" do
				wine_list.attributes[:product_attributes].count.should eq(25)
			end
		end

		context "with varietal filter" do
			let!(:first_type)  { :varietal }
			let!(:second_type) { :appellation } 
			before do
				@test_attribute1 = FactoryGirl.create(first_type)
				@negative_attribute1 = FactoryGirl.create(first_type)

				@test_attribute2 = FactoryGirl.create(second_type)
				@negative_attribute2 = FactoryGirl.create(second_type)

				@one_wine = FactoryGirl.create(:wine, { first_type => @test_attribute1, 
																								second_type => @test_attribute2 })
				@another_wine = FactoryGirl.create(:wine, { first_type => @negative_attribute1, 
																										second_type => @negative_attribute2 })
				wine_list.get({ first_type => @test_attribute1.id })
			end

			its(:list) { should be_a_kind_of(ActiveRecord::Relation) }

			it "should only have wines that belong to the filter" do
				wine_list.list.should include(@one_wine)
				wine_list.list.should_not include(@another_wine)
			end

			it "should only have attributes that belong to the filter" do
				wine_list.attributes[first_type].should include(@test_attribute1)
				wine_list.attributes[second_type].should include(@test_attribute2)
				wine_list.attributes[first_type].should_not include(@negative_attribute1)
				wine_list.attributes[second_type].should_not include(@negative_attribute2)
			end
		end

		context "with appellation filter" do
			[:appellation].each do |type|

				before do
					@test_attribute = FactoryGirl.create(type)
					@negative_attribute = FactoryGirl.create(type)
					@one_wine = FactoryGirl.create(:wine, { type => @test_attribute })
					@another_wine = FactoryGirl.create(:wine, { type => @negative_attribute })
					wine_list.get({ type => @test_attribute.id })
				end

				it_behaves_like "a wine list filter", type
			end
		end


		#TODO: DRY this up, repetitive
		context "with product_attribute" do
			let!(:type) { :product_attributes }
			before do
				@test_attribute = FactoryGirl.create(type.singularize)
				@negative_attribute = FactoryGirl.create(type.singularize)
				@one_wine = FactoryGirl.create(:wine)
				@another_wine = FactoryGirl.create(:wine)
				@one_wine.product_attributes << @test_attribute
				@another_wine.product_attributes << @negative_attribute
				wine_list.get({ type => @test_attribute.id })
			end

			it_behaves_like "a wine list filter", :product_attributes
		end

		context "with hierarchical data (region)" do
			let!(:type) {:region}
			let!(:child_type) { :appellation } 
				before do
					@test_attribute = FactoryGirl.create(child_type)
					@negative_attribute = FactoryGirl.create(child_type)
					@one_wine = FactoryGirl.create(:wine, { child_type => @test_attribute })
					@another_wine = FactoryGirl.create(:wine, { child_type => @negative_attribute })
					wine_list.get({ type => @test_attribute.region.id }) #interesting bug that was caught by ordering
				end

			its(:list) { should be_a_kind_of(ActiveRecord::Relation) }

			it "should only have wines that belong to the region filter" do
				wine_list.list.should include(@one_wine)
				wine_list.list.should_not include(@another_wine)
			end

			it "should only have attributes that belong to the region filter" do
				wine_list.attributes[type].should include(@test_attribute.region)
				wine_list.attributes[type].should_not include(@negative_attribute.region)
			end
		end

		# TODO: This is awfully painful and doesn't have great test coverage.
		# Need to figure out how to generalize the tests and test combinations of them.
		context "with multiple attributes" do
			context "two attributes" do
				let!(:first_type)  { :varietal }
				let!(:second_type) { :appellation } 
				before do
					@test_attribute1 = FactoryGirl.create(first_type)
					@negative_attribute1 = FactoryGirl.create(first_type)

					@test_attribute2 = FactoryGirl.create(second_type)
					@negative_attribute2 = FactoryGirl.create(second_type)

					@one_wine = FactoryGirl.create(:wine, { first_type => @test_attribute1, 
																									second_type => @test_attribute2 })
					@another_wine = FactoryGirl.create(:wine, { first_type => @negative_attribute1, 
																											second_type => @negative_attribute2 })
					wine_list.get({ first_type => @test_attribute1.id,
													second_type => @test_attribute2.id })
				end

				it "should only have wines that belong to the designated filters" do
					wine_list.list.should include(@one_wine)
					wine_list.list.should_not include(@another_wine)
				end

				it "should only have attributes that belong to the region filter" do
					wine_list.attributes[first_type].should include(@test_attribute1)
					wine_list.attributes[second_type].should include(@test_attribute2)
					wine_list.attributes[first_type].should_not include(@negative_attribute1)
					wine_list.attributes[second_type].should_not include(@negative_attribute2)
				end

			end

		end



	end

	
end