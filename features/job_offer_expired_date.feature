Feature: Job Offers expired date
  In order to renovate my job offers
  As a job offerer
  I want to set an expired date to my offers

  Background:
  	Given I create a new offer with "Programmer job" as the title 
    And 20/10/22 as the expired date

  @wip
  Scenario: Not expired job offer
    When I visit my offers list on 19/10/22
    Then I should see "Programmer job" in my offers list

  @wip
  Scenario: Expired job offer
    When I visit my offers list on 21/10/22
    Then I should not see "Programmer job" in my offers list