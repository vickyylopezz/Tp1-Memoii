@wip
Feature: Job Offers expired date
  In order 
  As a job offerer
  I want to manage my offers

  Background:
  	Given I create a new offer with "Programmer job" as title and 20/10/22 as expired date
    And today is 18/10/22

  @wip
  Scenario: Valid job offer
    When I visit my offers list on 19/10/22
    Then I should see "Programmer job" in my offers list

  @wip
  Scenario: Expired job offer
    When I visit my offers list on 21/10/22
    Then I should not see "Programmer job" in my offers list