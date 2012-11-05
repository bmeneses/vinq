Feature: Wines Page

@wine_fixture
Scenario: Visiting wines page
  When I visit the wines page
  Then I should see some wines

Scenario Outline: Wines pagination
	Given I set pagination to <page_limit> wines
	When I visit the wines page
	Then I should only see <page_limit> wines

	Examples:
	| page_limit |
	| 20				 |
	| 10				 |
