CAPTURE_A_NUMBER = Transform /^(\d+)$/ do |number|
	puts ' in capture block'
	number.to_i
end

CAPTURE_A_WORD= Transform /^.*$/ do |word|
	word
end


