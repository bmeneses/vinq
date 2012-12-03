
When /^I visit the wines page$/ do
  visit wines_path
end

Then /^I should see some wines$/ do
	page.should have_content('Test Wine')	
	page.should have_content('Test Appellation')
end

# TODO: UGH why doesn't capture_a_number work?
Given /^I set pagination to (#{CAPTURE_A_NUMBER}) wines$/ do |page_limit|
	WillPaginate.per_page = page_limit.to_i
end

Given /^I should only see (#{CAPTURE_A_NUMBER}) wines$/ do |limit|
	count = (@wine_count + 1).to_s
	page.should_not have_content("#{count}-TestWine")
end

Then /^I should see more than (#{CAPTURE_A_NUMBER}) appellations$/ do |number|
	count = (@appellation_count + 1).to_s
	page.should have_content("#{count}-TestAppellation")

end

Given /^I create (#{CAPTURE_A_NUMBER}) wines$/ do |wine_count|
	wine_count.to_i.times { FactoryGirl.create(:wine_complete) }
	
	@wine_count = Wine.last.name.match(/^(\d+)-TestWine$/)[1].to_i
	@appellation_count = Appellation.unscoped.order("id ASC").last.name.match(/^(\d+)-TestAppellation$/)[1].to_i
end

Given /^I create one more wine$/ do
	FactoryGirl.create(:wine_complete)
end


