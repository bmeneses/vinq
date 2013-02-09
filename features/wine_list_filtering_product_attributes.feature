Feature: Wine Listing Filtering - Product Attribute

As a user I want to be able to filter using appellations so that I can view specific appellations on the main page.

Scenario Outline: wine listing
	Given I have a wine with attribute <attr_1>
	And I have another wine with attribute <attr_2>
	When I visit the wines page
	Then I should see a link for <attr_1>
	Then I should see a link for <attr_2>
	And I should see wines with attribute <attr_1>
	And I should see wines with attribute <attr_2>
	
	Examples:
	| attr_2        | attr_1	 |
	| Bold	  			| Earthy	 |


Scenario Outline: product_attribute filtering
	Given I have a wine with attribute <attr_1>
	And I have another wine with attribute <attr_2>
	When I visit the wines page

	And I click on the <attr_1> link
	Then I should see wines with attribute <attr_1>
	Then I should not see wines with attribute <attr_2>
	And I should not see a link for <attr_1>
	And I should not see a link for <attr_2>
	And I should see a link for Clear All Filters
	And I should see a link to clear the <attr_1> filter

	Examples:
	| attr_2        | attr_1	 |
	| Bold	  			| Earthy	 |


Scenario Outline: cancel product_attribute filtering
	Given I have a wine with attribute <attr_1>
	And I have another wine with attribute <attr_2>
	When I visit the wines page
	And I click on the <attr_1> link
	And I clear the <attr_1> filter
	Then I should see a link for <attr_2>
	And I should see a link for <attr_1>
	And I should see wines with attribute <attr_1>
	And I should see wines with attribute <attr_2>

	Examples:
	| attr_2        | attr_1	 |
	| Bold	  			| Earthy	 |

