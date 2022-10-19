Feature: Job Offers expired date
  In order to renovate my job offers
  As a job offerer
  I want to set an expired date to my offers

  Background:
  	Given I am logged in as job offerer
    And I create a new job offer with "Programmer job" as the title and 20/10/22 as the expired date

  Scenario: Not expired job offer
    When I visit my offers list on 19/10/22
    Then I should see "Programmer job" in my offers list

  Scenario: Expired job offer
    When I visit my offers list on 21/10/22
    Then I should not see "Programmer job" in the offers list

  @wip
  Scenario: Republish expired job offer
  When I visit my offers list on 21/10/22
  And republish "Programmer job" expired offer with date 23/10/22
  Then I should see "Programmer job" and 23/10/22 in my offers list
  