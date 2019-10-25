Feature: Job offer view job applications quantity
  In order to know how many people has applied to my offer
  As a job offerer
  I want to view job applications quantities for each offer in my offers view

  Background:
    Given I am logged in as job offerer      
    And only a "Web Programmer" offer exists in the offers list

  Scenario: Job applications is zero when nobody has applied to the offer
    Given 0 users apply to "Web Programmer" offer
    When I access to my offers page
    Then I should see 0 job applications for "Web Programmer" offer

  @wip
  Scenario: Job applications displays number of postulated applicants
    Given 4 users apply to "Web Programmer" offer
    When I access to my offers page
    Then I should see 4 job applications for "Web Programmer" offer