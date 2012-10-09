module ModelCallbacks
		MAX_LENGTH_NAME_FIELD = 255
		def truncate_name
		  name = name[0..MAX_LENGTH_NAME_FIELD]
		end
end

