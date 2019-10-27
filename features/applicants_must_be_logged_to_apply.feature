Feature: Applicants must be logged to apply
  In order to not let unregistered applicants to apply
  As JobVacancy owner
  I want applicants to be logged in to apply

  Background:
    Given only a "Web Programmer" offer exists in the offers list

  Scenario: Logged applicant tries to apply to an offer
    Given applicant is logged in as job offerer
    And applicant access the offers list page
    When applicant tries to apply
    Then applicant should be in offer apply page

  Scenario: Not logged applicant redirected to login when try to apply
    Given applicant is not logged in
    And applicant access the offers list page
    When applicant tries to apply
    Then applicant should be in login page
  
  Scenario: Applicant is redirected to offer apply after login
    Given applicant is not logged in
    And applicant access the offers list page
    When applicant tries to apply
    And applicant logins
    Then applicant should be in offer apply page

  @wip
  Scenario: Applicant is redirected to offer apply after registering
    Given applicant is not logged in
    And applicant access the offers list page
    When applicant tries to apply
    And applicant registers
    Then applicant should be in offer apply page

  @wip
  Scenario: Applicant can not access to apply by URL if not logged in
    Given applicant is not logged in
    And applicant access the offers list page
    When applicant navigate to offer apply url
    Then applicant should be in login page