Feature: Job Application
  In order to get a job
  As a candidate
  I want to apply to an offer

  Background:
  	Given only a "Web Programmer" offer exists in the offers list
    And I am logged in as job offerer

  Scenario: Apply to job offer
    Given I access the offers list page
    When I apply
    Then I should receive a mail with offerer info