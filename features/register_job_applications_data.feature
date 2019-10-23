Feature: Register job applications data
  In order to collect job applications data
  As offerer
  I want JobVacancy to store job applications data when applicants apply to my offers

  Background:
    Given only a "Web Programmer" offer exists in the offers list
    And applicant access the offers list page

  Scenario: Register job application data
    When Applicant 'user@test.com' applies with expected remuneration 10000.0
    Then Email 'user@test.com' and expected remuneration 10000.0 should be stored for "Web Programmer" offer