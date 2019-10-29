Feature: Account Lock

  In order to protect my account
  As User
  I want my account to be locked if login fails repeatedly

  Background:
    Given User is registered with email 'user@test.com' and password 'PassW0rd!123'

  Scenario: Account locked because a repeatedly login fails
    When I try to access with email 'user@test.com' and wrong password 3 times
    Then An error indicating that the account is locked should be displayed if user tries to log in

  Scenario: Account previously locked can login after predefinited time
    Given User with email 'user1@test.com' was locked yesterday
    When I try to access with email 'user1@test.com'
    Then I should be logged in

  Scenario: The number of account login fails is restored after logging in
    When I try to access with email 'user@test.com' and wrong password 2 times
    And I try to access with email 'user@test.com'
    And I logout
    And I try to access with email 'user@test.com' and wrong password 1 times
    And I try to access with email 'user@test.com'
    Then I should be logged in
