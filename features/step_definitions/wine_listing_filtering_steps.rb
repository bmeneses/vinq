Given /^I have (?:a|another) wine in appellation (#{CAPTURE_A_WORD}) and region (#{CAPTURE_A_WORD})$/ do |appellation, region|
  wine = FactoryGirl.create(:wine, 
  														appellation: FactoryGirl.create(:appellation, 
  																														name: appellation))
  wine.appellation.region = FactoryGirl.create(:region, name: region )
  wine.appellation.save
end


When /^I (?:have)?\s?click(?:ed)? on the (#{CAPTURE_A_WORD}) (?:link|filter)$/ do |link_text|
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