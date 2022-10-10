Feature: Job Offer Salary
  In order to get employees
  As a job offerer
  I want to publish the amount i'm able to pay.

  Background:
      Given I am logged in as job offerer
  
  Scenario: Create new offer with $ 1000 anual salary.
    When I create a new offer with "Java" and 1000 salary
    Then I should see a offer created confirmation message
    And  I should see "Java 1000" in my offers list

  Scenario: Create new offer with no anual salary.
    When I create a new offer with "Ruby" and no salary
    Then I should see a offer created confirmation message
    And  I should see "Ruby N/A" in my offers list

  Scenario: Update offer from no anual salary to $ 1000 
    Given I have "Programmer vacancy" with no anual salary offer in my offers list
    When I change the salary to 1000
    Then I should see a offer updated confirmation message
    And  I should see "Programmer vacancy 1000" in my offers list
    
  Scenario: Update offer from 1000 to 3000 anual salary
    Given I have "Ruby" with 1000 anual salary offer in my offers list
    When I change the salary to 3000
    Then I should see a offer updated confirmation message
    And  I should see "Ruby 3000" in my offers list

  