Feature: My Offers
  In order to be aware of the amount of applicants to one offer
  As a job offerer
  I want to know the amount of applicants of certain offer

  Background:
      Given I am logged in as job offerer "Pepe"

  Scenario: User applies to one job without applicants
    Given there is an offer with title "Java developer" and without any applicants
    When the user "pepe_distinto@gmail.com" applies to the job offer
    Then the applicants amount of the offer "Java developer" should be 1

  Scenario: User applies to the same job offer twice
    Given there is an offer with title "Java developer" and without any applicants
    And the user "pepe_distinto@gmail.com" applies to the job offer
    When the user "pepe_distinto@gmail.com" applies to the job offer again
    Then the applicants amount of the offer "Java developer" should be 1

  Scenario: Job offerer tries to delete an offer without any applicants
    Given there is an offer with title "Java developer" and without any applicants
    When I try to delete the offer "Java developer"
    Then the offer "Java developer" is successfully deleted

  Scenario: Job offerer tries to delete an offer with applicants
    Given there is an offer with title "Java developer" and with applicants
    When I try to delete the offer "Java developer"
    Then the offer "Java developer" is not deleted and I get an error message
