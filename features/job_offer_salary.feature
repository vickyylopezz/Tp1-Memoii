
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
  