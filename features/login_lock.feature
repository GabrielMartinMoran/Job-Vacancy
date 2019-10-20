Feature: Account Lock

  In order to protect my account
  As User
  I want my account to be locked if login fails repeatedly

  Background:
    Given User is registered with email 'user@test.com' and password 'PassW0rd!123'
  @wip
  Scenario: Account locked because a repeatedly login fails
    When I try to acces with email 'user@test.com' and wrong password 3 times
    Then An error indicating that the account is locked should be displayed if user tries to log in
  @wip
  Scenario: Account previously locked can login after predefinited time
    Given User with email 'user@test.com' is locked
    When 24 hours passed
    Then User should be able to login with email 'user@test.com'
