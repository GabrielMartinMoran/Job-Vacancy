Feature: Register job applications data
  In order to collect job applications data
  As offerer
  I want JobVacancy to store job applications data when applicants apply to my offers

  Background:
    Given only a "Web Programmer" offer exists in the offers list
    And applicant is logged in as job offerer
    And applicant access the offers list page

  Scenario: Register job application data
    When applicant applies with expected remuneration 10000.0
    Then applicant email and expected remuneration 10000.0 should be stored for "Web Programmer" offer