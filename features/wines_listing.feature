Feature: Wines Page

Scenario Outline: Wines pagination
	Given I set pagination to <page_limit> wines
	And I create <page_limit> wines
	And I create one more wine
	When I visit the wines page
	Then I should only see <page_limit> wines
	And I should see more than <page_limit> appellations

	# There is a problem with will_paginate that keeps limts other than 30 
  # from working
	Examples:
	| page_limit |
	| 30				 |
