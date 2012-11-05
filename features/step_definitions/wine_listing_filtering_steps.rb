Given /^I have a wine in appellation (#{CAPTURE_A_WORD}) and region (#{CAPTURE_A_WORD})$/ do |appellation, region|
  @first_wine = FactoryGirl.create(:wine, 
  														appellation: FactoryGirl.create(:appellation, 
  																														name: appellation))
  @first_wine.appellation.region = FactoryGirl.create(:region, name: region )
end

And /^I have another wine in appellation (#{CAPTURE_A_WORD}) and region (#{CAPTURE_A_WORD})$/ do |appellation, region|
  @second_wine = FactoryGirl.create(:wine, 
  														appellation: FactoryGirl.create(:appellation, 
  																														name: appellation))
  @second_wine.appellation.region = FactoryGirl.create(:region, name: region )
end


When /^I click on the (#{CAPTURE_A_WORD}) link$/ do |link_text|
	visit wines_path
  click_link link_text
end

Then /^I should not see wines from (#{CAPTURE_A_WORD})$/ do |attribute|
  page.should_not have_content(attribute)
end

Then /^I should not see a link for (#{CAPTURE_A_WORD})$/ do |link_text|
  page.should_not have_selector('a', text: link_text)
end

Then /^I should see a link for (#{CAPTURE_A_WORD})$/ do |link_text|
  page.should have_selector('a', text: link_text)
end