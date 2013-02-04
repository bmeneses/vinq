require File.dirname(__FILE__) + "/../../lib/ruby_extensions"
require 'spec_helper'

describe Symbol do

	describe "#pluralize" do
		before { @sym = :ruby }
		specify { @sym.pluralize.should eq(:rubies) }
	end

	describe "#singularize" do
		before { @sym = :horses }
		specify { @sym.singularize.should eq(:horse) }
	end
	
end

describe Array do 

	let(:test_array) { [:a, :b] }
	let(:cross_array) { [:c, :d] }
	let(:double_cross_array) { [:y, :z] }

	describe "#cross" do
		context "single cross" do
			specify { test_array.cross(cross_array).should 
			  					eq([[:a, :c], [:a, :d], [:b, :c], [:b, :d]]) }
		end

		context "double cross" do
			specify { test_array.cross(cross_array.cross(double_cross_array)).should
									eq([[:a, :c, :x], [:a, :c, :y], [:a, :d, :x], [:a, :d, :y],
											[:b, :c, :x], [:b, :c, :y], [:b, :d, :x], [:b, :d, :y]])}
		end

	end
end
