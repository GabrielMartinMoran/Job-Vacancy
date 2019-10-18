Feature: Registration user unique
  In order to not allow duplicated user in registration
  As User
  I want to show an error in registering when user already exists

  Background:
    Given User acceses to the register page

  Scenario: Registration when an user is not previously registered
    When User "user@test.com" tries to register
    Then User should be registered succesfully

  @wip
  Scenario: Registration when an user is already registered
    Given User "user@test.com" is already registered
    When User "user@test.com" tries to register
    Then User should see a message indicating error user is already registered