class WinesController < ApplicationController	
	require 'pry'
	helper_method :cap_and_pluralize_sym
	helper_method :deparameterize_filter
	helper_method :attribute_name_from_filter



	::WINE_FILTER_TYPES = [:region, :appellation, :varietal]
	FIRST = 0

	def index
		setup_index_filters
		add_index_filters_from_params
		@filter_conditions = active_filters
		@wines = query_wines_with_index_filter
		filter_attributes_on_wines
		@wines = @wines.paginate(page: params[:page])
	end

	def cap_and_pluralize_sym(sym)
		sym.to_s.capitalize.pluralize
	end

	def attribute_name_from_filter(type)
		@attributes[type][FIRST].name
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

	def add_index_filters_from_params
		WINE_FILTER_TYPES.each do |type|
			if !(params[type] == nil)
				session[:wine_index_filters].merge!(type => params[type])
			end
		end
	end

	def filter_attributes_on_wines
		WINE_FILTER_TYPES.each do |type|
			@attributes[type] = filter_attribute(type)
		end
	end

	def filter_attribute(attribute)
 		# @wines.map { |wine| wine.send(attribute) }.uniq
 		filtered_attributes = []
 		@wines.each do |wine|
 			this_attribute = wine.send(attribute)
 			unless this_attribute == nil
 				filtered_attributes << this_attribute
 			end
 		end
 		filtered_attributes.uniq.sort_by &:name
 	end

 	def active_filters
 		conditions = session[:wine_index_filters]
 	end

 	def wine_query_filter_conditions
 		conditions = session[:wine_index_filters]
 		conditions.inject({}) do |hash, (k,v)|
 			k = (k.to_s + "_id").to_sym
 			hash[k] = v.to_i
 			hash
 		end
 	end

 	def query_wines_with_index_filter
 		Wine.where(wine_query_filter_conditions)
 	end

 	# FILTER CLEARING
 	def clear_all_filters
 		session[:wine_index_filters] = nil
 	end

 end
