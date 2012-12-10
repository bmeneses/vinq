Feature: Wine Listing Filtering - Region

As a user I want to be able to filter using appellations so that I can view specific appellations on the main page.

Scenario Outline: Region filtering
	Given I have a wine in appellation <appellation_1> and region <region_1>
	And I have another wine in appellation <appellation_2> and region <region_2>
	And I have another wine in appellation <appellation_3> and region <region_3>
	When I visit the wines page 
	And I click on the <region_1> link
	Then I should not see wines from <appellation_2>
	And I should see wines from <appellation_1>
	And I should see wines from <appellation_3>
	And I should see a link for <appellation_1>
	And I should not see a link for <appellation_2>
	And I should not see a link for <region_1>
	And I should not see a link for <region_2>
	And I should see a link for Clear All Filters
	And I should see a link to clear the <region_1> filter

	Examples:
	| appellation_1 | region_1 | appellation_2 | region_2 |	appellation_3 | region_3 |
	| Oakville			| Napa		 | St. Emilion   | Bordeaux | Rutherford    | Napa     |

Scenario Outline: cancel all filters
	Given I have a wine in appellation <appellation_1> and region <region_1>
	And I have another wine in appellation <appellation_2> and region <region_2>
	And I have another wine in appellation <appellation_3> and region <region_3>
	When I visit the wines page 
	And I have clicked on the <region_1> filter
	And I click on the Clear All Filters link
	Then I should see a link for <region_2>
	And I should see a link for <appellation_2>
	And I should see wines from <appellation_2>

	Examples:
	| appellation_1 | region_1 | appellation_2 | region_2 |	appellation_3 | region_3 |
	| Oakville			| Napa		 | St. Emilion   | Bordeaux | Rutherford    | Napa     |


Scenario Outline: cancel Region filter
	Given I have a wine in appellation <appellation_1> and region <region_1>
	And I have another wine in appellation <appellation_2> and region <region_2>
	And I have another wine in appellation <appellation_3> and region <region_3>
	When I visit the wines page 
	And I have clicked on the <region_1> filter
	And I clear the <region_1> filter
	Then I should see a link for <region_2>
	And I should see a link for <appellation_2>

	Examples:
	| appellation_1 | region_1 | appellation_2 | region_2 |	appellation_3 | region_3 |
	| Oakville			| Napa		 | St. Emilion   | Bordeaux | Rutherford    | Napa     |
