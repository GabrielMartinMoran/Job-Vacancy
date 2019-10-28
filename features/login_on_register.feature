Feature: Login on register
  In order to be logged after registering
  As an user
  I want application to log me in when I register successfuly

  Background:
    Given I access to the register page

  Scenario: A user is logged in after registration
    When I fill email with 'loginonregister@test.com' and other fields with valid values
    And I try to register
    Then I should be logged in
