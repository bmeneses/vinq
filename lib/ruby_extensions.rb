class Symbol
	def pluralize
		to_s.pluralize.to_sym
	end

	def singularize
		to_s.singularize.to_sym
	end
end

class Array
	def cross(other)
		reduce([]) do |result, element|
			other.map do |c|
				result << [element, c].flatten
			end
			result
		end

	end
end
