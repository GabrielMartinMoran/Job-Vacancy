Feature: Registration user unique
  In order to not allow duplicated user in registration
  As User
  I want to show an error in registering when user already exists

  Background:
    Given User acceses to the register page

  Scenario: Registration when an user is not previously registered
    When User "user@test.com" tries to register
    Then User should be registered succesfully

  Scenario: Registration when an user is already registered
    Given User "user02@test.com" is already registered
    When User "user02@test.com" tries to register
    Then User should see a message indicating error user is already registered