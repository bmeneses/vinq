require File.dirname(__FILE__) + "/../../lib/ruby_extensions"
class WinesController < ApplicationController	

	helper_method :cap_and_pluralize_sym
	helper_method :deparameterize_filter
	helper_method :attribute_name_from_filter



	WINE_FILTER_TYPES = [:region, :appellation, :varietal, :product_attributes]
	HABTM_FILTER_TYPES = [:product_attributes]

	FIRST = 0
	
	def index
		setup_index_filters
		add_index_filters_from_params
		@filter_conditions = session[:wine_index_filters]

		list = WineList.new
		@wines = list.get(@filter_conditions).paginate(page: params[:page])
		@attributes = list.attributes
	end

	def cap_and_pluralize_sym(sym)
		sym.to_s.humanize.titleize.pluralize
	end

	def attribute_name_from_filter(type)
		HABTM_FILTER_TYPES.include?(type) ? @attributes[type.pluralize].first.name :
																				@attributes[type].first.name
end


	def clear_filter
		filter_to_clear = params[:filter].to_sym
		if filter_to_clear == :all
			clear_all_filters
		else
			session[:wine_index_filters].delete(filter_to_clear)
		end
		redirect_to wines_path
	end



	private

	# FILTER SETTING
	def setup_index_filters
		session[:wine_index_filters] ||= {}
		@attributes = {}
	end


	#change order, this pre-supposes that the filter works
	def add_index_filters_from_params
		WINE_FILTER_TYPES.each do |type|
			#type = type.singularize
			if !(params[type] == nil)
				session[:wine_index_filters].merge!(type => params[type])
			end
		end
	end

	
 	# FILTER CLEARING
 	def clear_all_filters
 		session[:wine_index_filters] = nil
 	end

 end
