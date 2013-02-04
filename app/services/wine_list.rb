require File.dirname(__FILE__) + "/../../lib/ruby_extensions"
class WineList
	attr_accessor :list, :attributes

	WINE_FILTER_TYPES = [:region, :appellation, :varietal, :product_attributes]

	def get(params = {})
		@list = get_list(params)
		@attributes = get_attributes(params)
	end

	private

		def get_list(params)
			if params == {}
				list = Wine.scoped
			else
				list = Wine.includes(associations(params)).where(filter_conditions(params))
			end
			list
		end

		def get_attributes(params)
			attrs = {}
			WINE_FILTER_TYPES.each do |type|
				model = type.to_s.classify.constantize
				if params[type] == nil
					attrs[type] = model.scoped.pluck(:name)
				else
					attrs[type] = model.where(id: params[type]).pluck(:name)
				end
			end
			attrs
		end

		def filter_conditions(params)
			#TODO: this is friggen magic... need to understand the (k,v) part
			params.inject({}) do |hash, (k,v)|
				k = k.pluralize
				hash[k] = { id: v.to_i }
				hash
			end
		end

		def associations(params)
			params.map { |key, val| key }
		end


end
