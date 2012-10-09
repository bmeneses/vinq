module SharedCallbacksValidations

		MAX_LENGTH_NAME_FIELD = 255

		def self.included(base)
			base.before_save :truncate_name
		end

		def truncate_name
		  self.name = self.name.slice(0, MAX_LENGTH_NAME_FIELD - 1)
		end

end

