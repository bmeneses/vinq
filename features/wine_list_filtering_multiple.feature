Feature: Wine Listing Filtering - Multiple

As a user I want to be able to filter using multiple filter criteria so I can find wines.

Scenario Outline: Region Drilldown
	Given I have a wine in appellation <appellation_1> and region <region_1>
	And I have another wine in appellation <appellation_2> and region <region_2>
	And I have another wine in appellation <appellation_3> and region <region_3>
	When I visit the wines page 
	And I click on the <region_1> link
	Then I should see wines from <appellation_1>
	And I should see wines from <appellation_3>
	When I click on the <appellation_1> link
	Then I should see wines from <appellation_1>
	And I should not see wines from <appellation_2>
	And I should not see wines from <appellation_3>
	And I should see a link for Clear All Filters
	And I should see a link to clear the Regions filter
	And I should see a link to clear the Appellations filter

	Examples:
	| appellation_1 | region_1 | appellation_2 | region_2 |	appellation_3 | region_3 |
	| Oakville			| Napa		 | St. Emilion   | Bordeaux | Rutherford    | Napa     |

Scenario Outline: Region Drill-Up from Appellation
	Given I have a wine in appellation <appellation_1> and region <region_1>
	And I have another wine in appellation <appellation_2> and region <region_2>
	And I have another wine in appellation <appellation_3> and region <region_3>
	When I visit the wines page 
	And I click on the <region_1> link
	When I click on the <appellation_1> link
	And I clear the Appellation filter
	Then I should see wines from <appellation_1>
	And I should see wines from <appellation_3>
	And I should not see wines from <appellation_2>
	And I should see a link for Clear All Filters
	And I should see a link to clear the Regions filter
	And I should not see a link to clear the Appellations filter

	Examples:
	| appellation_1 | region_1 | appellation_2 | region_2 |	appellation_3 | region_3 |
	| Oakville			| Napa		 | St. Emilion   | Bordeaux | Rutherford    | Napa     |