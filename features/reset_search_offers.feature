@wip
Feature: Reset a search of offers
  In order to get back all job offers
  As an applicant
  I want to reset a search of job offers

  Background:
  	Given 5 job offers exist in the offers list

  @wip
  Scenario: Reset a search of offers
    Given I search for "Web Programmer" offers
    And only 1 "Web Programmer" offer exists in the offers list
    When I reset the search of job offers
    Then 5 job offers exist in the offers list