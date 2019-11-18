Feature: User profile modification
  In order to have my profile information updated
  As an user
  I want application to let me update my profile

  Background:
    Given I am logged in as "profileupdater@test.com"

  Scenario: Email link redirects to profile update page 
    When I click on email link
    Then I should be in profile update page

  Scenario: Update user information
    Given I am in profile update page
    When I update my name, short bio and prefered tags
    And I click on save button
    Then My profile should be updated
    And My password should be not updated

  Scenario: Update user password
    Given I am in profile update page
    When I update my password and password confirmation
    And I click on save button
    Then My password should be updated