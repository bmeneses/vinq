Feature: Wine Listing Filtering - Appellation, Region & Area

As a user I want to be able to filter using appellations so that I can view specific appellations on the main page.

Scenario Outline: appellation/region listing
	Given I have a wine in appellation <appellation_1> and region <region_1>
	And I have another wine in appellation <appellation_2> and region <region_2>
	When I visit the wines page
	Then I should see a link for <appellation_1>
	And I should see a link for <appellation_2>
	And I should see a link for <region_1>
	And I should see a link for <region_2>

	Examples:
	| appellation_1 | region_1 | appellation_2 | region_2 |	
	| Oakville			| Napa		 | St. Emilion   | Bordeaux |



Scenario Outline: appellation/region filtering
	Given I have a wine in appellation <appellation_1> and region <region_1>
	And I have another wine in appellation <appellation_2> and region <region_2>
	When I click on the <appellation_1> link
	Then I should not see wines from <appellation_2>
	And I should see a link for <appellation_1>
	And I should not see a link for <appellation_2>

	Examples:
	| appellation_1 | region_1 | appellation_2 | region_2 |	
	| Oakville			| Napa		 | St. Emilion   | Bordeaux |


	