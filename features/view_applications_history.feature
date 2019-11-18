Feature: View applications history
  In order to know about my applications
  As a applicant
  I want to view my applications history

  Background:
    Given I am logged in as job offerer
    And only a "Web Programmer" offer exists in the offers list
    And I applied for Job Offer with expected remuneration 10000.0

  Scenario: Applications history is displayed in my applications
    When I access to my applications
    Then I should see Job Offer application info