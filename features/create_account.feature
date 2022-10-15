Feature: User registration
  In order to distinguish between users
  As a JobVacancy user
  I want to create an account and be able to login

  Scenario: Successfully registration
    Given there is no registered user with the email "pepe@test.com"
    When I try to register an user with the email "pepe@test.com"
    Then the account is successfully created

  @wip
  Scenario: Try to register an user with existing email
    Given there is an user already registered with the email "pepe@test.com"
    When I try to register an user with the email "pepe@test.com"
    Then the account is not created and I get an error message