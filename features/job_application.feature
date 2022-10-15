Feature: Job Application
  In order to get a job
  As a candidate
  I want to apply to an offer

  Background:
  	Given only a "Web Programmer" offer exists in the offers list

  @wip
  Scenario: Apply to job offer
    Given I access the offers list page
    When I apply
    Then I should receive a mail with offerer info

  Scenario: Apply to job offer and adding personal description
    Given I access the offers list page
    When I apply with "Hi, I'm Bob, I'm 50 years old and I love programming" as personal description
    Then I should receive a mail with offerer info
  
  Scenario: Apply to job offer with 600 characters gets error message
    Given I access the offers list page
    When I apply with a 600 characters personal description
    Then I should get an error message

  Scenario: Apply to job offer without adding personal description
    Given I access the offers list page
    And I apply
    Then I should get an cannot be blank error message

  Scenario: Fill in a job application form adding a cv link
    Given I access the offers list page
    When I fill in the form application
    Then I have the chance to add a link to my cv

  Scenario: Apply to job offer adding a cv link
    Given I access the offers list page
    When I apply with "linkedin-my_cv.com" as my cv link
    Then the application is successfully submited

  @wip
  Scenario: Apply to job offer without adding a cv link
    Given I access the offers list page
    When I apply without a cv link
    Then the application is successfully submited
