Feature: My Offers
  In order to be aware of the amount of applicants to one offer
  As a job offerer
  I want to know the amount of applicants of certain offer

  Background:
      Given I am logged in as job offerer "Pepe"
  
  @wip
  Scenario: User applies to one job without applicants
    Given there is an offer with title "Java developer" and without any applicants
    When the user "pepe_distinto@gmail.com" applies to the job offer
    Then the applicants amount of the offer "Java developer" should be 1

  @wip
  Scenario: User applies to the same job offer twice
    Given there is an offer with title "Java developer" and without any applicants
    And the user "pepe_distinto@gmail.com" applies to the job offer
    When the user "pepe_distinto@gmail.com" applies to the job offer again
    Then the applicants amount of the offer "Java developer" should be 1