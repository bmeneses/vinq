# TODO: consolidate negative step definition

Given /^I have (?:a|another) wine in appellation (#{CAPTURE_A_WORD}) and region (#{CAPTURE_A_WORD})$/ do |appellation, region|
  wine = FactoryGirl.create(:wine)

  if !Appellation.find_by_name(appellation)
    wine.appellation = FactoryGirl.create(:appellation, name: appellation)
  else
    wine.appellation = Appellation.find_by_name(appellation)
  end

  if !Region.find_by_name(region)
    wine.appellation.region = FactoryGirl.create(:region, name: region )
  else
    wine.appellation.region = Region.find_by_name(region)
  end
  wine.appellation.save
  wine.save
end

# VARIETAL
Given /^I have a (#{CAPTURE_A_WORD}) wine$/ do |varietal|
  wine = FactoryGirl.create(:wine_complete,
                            varietal: FactoryGirl.create(:varietal, name: varietal))
end

Then /^I should( not)? see (#{CAPTURE_A_WORD}) wines$/ do |negate, attribute|
  if negate
    page.should_not have_selector('span.appellation-name', text: attribute)
  else
    page.should have_selector('span.appellation-name', text: attribute)
  end
end


# APPELLATION & REIGION
When /^I clear the (#{CAPTURE_A_WORD}) filter$/ do |filter|
	click_link filter.parameterize.downcase + "-clear-link"
end

When /^I (?:have)?\s?click(?:ed)? on the (#{CAPTURE_A_WORD}) (?:link|filter)$/ do |link_text|
  click_link link_text
end



Then /^I should( not)? see wines from (#{CAPTURE_A_WORD})$/ do |negate, attribute|
  if negate
    page.should_not have_selector('span.appellation-name', text: attribute)
  else
    page.should have_selector('span.appellation-name', text: attribute)
  end
end

Then /^I should not see a link for (#{CAPTURE_A_WORD})$/ do |link_text|
  page.should_not have_selector('a', text: link_text)
end

Then /^I should see a link for (#{CAPTURE_A_WORD})$/ do |link_text|
  page.should have_selector('a', text: link_text)
end

Then /^I should( not)? see a link to clear the (#{CAPTURE_A_WORD}) filter$/ do |negate, link_text|
	negate ? page.should_not(have_content("#{link_text} (clear)")) : page.should(have_content("#{link_text} (clear)"))
end

# PRODUCT_ATTRIBUTE
Given /^I have (?:a|another) wine with attribute (#{CAPTURE_A_WORD})$/ do |attrib|
  wine = FactoryGirl.create(:wine)
  wine.product_attributes << FactoryGirl.create(:product_attribute, name: attrib)
end

Then /^I should( not)? see wines with attribute (#{CAPTURE_A_WORD})$/ do |negate, attribute|
  if negate
    page.should_not have_selector('span.attribute-name', text: attribute)
  else
    page.should have_selector('span.attribute-name', text: attribute)
  end
end

