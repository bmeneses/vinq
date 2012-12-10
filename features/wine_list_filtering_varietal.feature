Feature: Wine Listing Filtering - Varietal

As a user I want to be able to filter using varietals so that I can view specific varietals on the main page.

Scenario Outline: Varietal filtering

	Given I have a <varietal_1> wine
	And I have a <varietal_2> wine
	When I visit the wines page 
	And I click on the <varietal_1> link
	Then I should not see <varietal_2> wines
	And I should not see <varietal_2> wines
	And I should not see a link for <varietal_2>
	And I should see a link for Clear All Filters
	And I should see a link to clear the <varietal_1> filter

	Examples:
	| varietal_1          | varietal_2 | 
	| Cabernet Sauvignon	| Gamay Noir | 


Scenario Outline: cancel Varietal filter
	Given I have a <varietal_1> wine
	And I have a <varietal_2> wine
	When I visit the wines page 
	And I click on the <varietal_1> link
	And I clear the <varietal_1> filter
	Then I should see a link for <varietal_1>
	And I should see a link for <varietal_2>

	Examples:
	| varietal_1          | varietal_2 | 
	| Cabernet Sauvignon	| Gamay Noir | 
