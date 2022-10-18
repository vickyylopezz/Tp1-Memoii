Feature: Offerer email
  In order to be aware of my offers
  As a offerer
  I want to receive an email with the applicant information when applies

  Background:
  	Given only a "Web Programmer" offer exists owned by "offerer1@test.com" in the offers list

  Scenario: Apply to job offer
    Given an applicant who fills the application form
    When the applicant applies
    Then I should receive an email with the applicant information

  Scenario: Apply to job offer twice
    Given an applicant who fills the application form and applies
    When the applicant applies to the same job offer again using the same email
    Then I should not receive a second email and I get an error message