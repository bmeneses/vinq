
When /^I visit the wines page$/ do
  visit wines_path
end

Then /^I should see some wines$/ do
	page.should have_content('Test Wine#1')	
	page.should have_content('Test Appellation#9')
end

# TODO: UGH why doesn't capture_a_number work?
Given /^I set pagination to (#{CAPTURE_A_NUMBER}) wines$/ do |page_limit|
	WillPaginate.per_page = page_limit.to_i
	(page_limit.to_i + 5).times { FactoryGirl.create(:wine_complete) }
end

Given /^I should only see (#{CAPTURE_A_NUMBER}) wines$/ do |limit|
	page.should_not have_content("Test Wine#{limit.to_i + 1}")
end


Before ('@wine_fixture') do 
	20.times { FactoryGirl.create(:wine_complete) }
end
