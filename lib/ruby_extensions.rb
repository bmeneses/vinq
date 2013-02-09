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

	def pairwise_cross
		reduce([]) do |result, element|
			map do |c|
				unless element == c
					result << [element, c].flatten 
				end
			end
			result
		end
	end

end
