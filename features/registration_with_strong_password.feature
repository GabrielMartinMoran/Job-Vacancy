Feature: Registration with strong passwords
  In order register
  As an user
  I want application to require strong passwords

  Background:
    Given I access to the register page

  Scenario: A user tries to register with a strong password
    When I fill password with "A1f43f5%" and password confirmation with "A1f43f5%"
    And I try to register
    Then I should be able to login