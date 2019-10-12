Feature: Registration with short bio
  In order to allow user registration
  As JobVacancy owner
  I want users to provide a short bio when registering

  Background:
    Given User acceses to the register page

  Scenario: Registration with a valid length bio
    When User fills email with '50charslengthbio@test.com' and password, password confirmation and name with valid values
    And User fills short bio with a text of 50 characters length
    And User tries to register
    Then User should be able to login with email '50charslengthbio@test.com'

  Scenario: Registration with a long bio
    When User fills email with 'longbio@test.com' and password, password confirmation and name with valid values
    And User fills short bio with a text of 501 characters length
    And User tries to register
    Then User should see a message indicating error on short bio

  @wip
  Scenario: Registration withouth providing bio
    When User fills email with 'notprovidingbio@test.com' and password, password confirmation and name with valid values
    And User tries to register
    Then User should see a message indicating error on short bio