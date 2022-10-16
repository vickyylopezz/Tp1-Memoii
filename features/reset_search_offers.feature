@wip
Feature: Reset a search of offers
  In order to get back all job offers
  As an applicant
  I want to reset a search of job offers

  Background:
  	Given "Web Programmer" job offer exist in the offers list
    And "Mobile programmer" job offer exist in the offers list

  
  Scenario: Reset a search of offers
    Given I search for "Web Programmer" offers
    And only "Web Programmer" offer exists in the offers list
    When I reset the search of job offers
    Then "Web Programmer" and "Mobile programmer" job offers exist in the offers list