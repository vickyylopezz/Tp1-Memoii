@wip
Feature: User Password
  In order to avoid data leaking
  As Job Vacancy owner
  I want user's password to be strong enough to not be easily hacked, having al least eight characters long, an uppercase letter, a lowercase letter and one number

  Background:
    Given my name is "Pepe" and my email is "pepe@pepito.com"
  
  Scenario: Password without uppercase
    Given I complete the password fields with "testeando1"
    When I try to create the account
    Then My account is not created and I get an error message
  
  @wip
  Scenario: Password without lowercase
    Given I complete the password fields with "TESTEANDO1"
    When I try to create the account
    Then My account is not created and I get an error message
  
  @wip
  Scenario: Password without number
    Given I complete the password fields with "Testeando"
    When I try to create the account
    Then My account is not created and I get an error message
  
  @wip
  Scenario: Password with less than eight characters
    Given I complete the password fields with "Test1"
    When I try to create the account
    Then My account is not created and I get an error message
  
  @wip
  Scenario: Password with more than eight characters, with uppercase, with lowercase and with a number
    Given I complete the password fields with "Testeando1"
    When I try to create the account
    Then My accout is created successfully
