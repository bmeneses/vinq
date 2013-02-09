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

shared_examples_for "a wine list filter checking both attributes" do
	its(:list) { should be_a_kind_of(ActiveRecord::Relation) }

	it "should only have wines that belong to the filter" do
		wine_list.list.should include(@one_wine)
		wine_list.list.should_not include(@another_wine)
	end

	it "should only have attributes that belong to the filter" do
		wine_list.attributes[test_type].should include(@test_attribute1)
		wine_list.attributes[passive_type].should include(@test_attribute2)
		wine_list.attributes[test_type].should_not include(@negative_attribute1)
		wine_list.attributes[passive_type].should_not include(@negative_attribute2)
	end
end


shared_examples_for "a wine list filter with single parameter" do
	before { wine_list.get({ test_type => @test_attribute1.id }) }
	it_behaves_like "a wine list filter checking both attributes"
end

shared_examples_for "a wine list filter with multiple parameters" do
	before { wine_list.get({ test_type => @test_attribute1.id,
												passive_type => @test_attribute2.id }) }
	it_behaves_like "a wine list filter checking both attributes"
end

###### MAIN TEST BODY HERE

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

		context "pairwise testing" do
			[:appellation, :varietal].pairwise_cross.each do |pair|
				context "with varietal filter" do
					let!(:test_type)  { pair.first }
					let!(:passive_type) { pair.last } 
					before do
						@test_attribute1 = FactoryGirl.create(test_type)
						@negative_attribute1 = FactoryGirl.create(test_type)

						@test_attribute2 = FactoryGirl.create(passive_type)
						@negative_attribute2 = FactoryGirl.create(passive_type)

						@one_wine = FactoryGirl.create(:wine, { test_type => @test_attribute1, 
																										passive_type => @test_attribute2 })
						@another_wine = FactoryGirl.create(:wine, { test_type => @negative_attribute1, 
																												passive_type => @negative_attribute2 })
					end

					it_behaves_like "a wine list filter with single parameter"
					it_behaves_like "a wine list filter with multiple parameters"
				end
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
	end
end

