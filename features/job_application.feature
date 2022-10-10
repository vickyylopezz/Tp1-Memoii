Feature: Job Application
  In order to get a job
  As a candidate
  I want to apply to an offer

  Background:
  	Given only a "Web Programmer" offer exists in the offers list

  Scenario: Apply to job offer
    Given I access the offers list page
    When I apply
    Then I should receive a mail with offerer info

  @wip
  Scenario: Apply to job offer and adding personal description
    Given I access the offers list page
    When I write "Hi, I'm Bob, I'm 50 years old and I love programming" as personal description
    And I apply
    Then I should receive a mail with offerer info
  @wip
  Scenario: Apply to job offer with 600 characters gets error message
    Given I access the offers list page
    When I write a 600 characters personal description
    And I apply
    Then I should get an error message
  @wip
  Scenario: Apply to job offer without adding personal description
    Given I access the offers list page
    When I don't write a personal description
    And I apply
    Then I should get an error message