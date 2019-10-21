Feature: Expected remuneration on job application
  In order to get a job
  As a candidate
  I want to specify expected remuneration when applying to an offer
  
  Background:
    Given only a "Web Programmer" offer exists in the offers list
    And I access the offers list page

  Scenario: Apply to job offer providing expected remuneration
    When I try to apply
    And I fill expected remuneration with 10000.0
    And I submit application
    Then the job offerer receive a mail with application info
    And expected remuneration in mail is '10000.0'

  Scenario: Apply to job offer not providing expected remuneration
    When I try to apply
    And I submit application
    Then I should receive a mail with offerer info
    And the job offerer receive a mail with application info
    And expected remuneration in mail is 'Not specified'

  Scenario: Apply to job offer providing negative expected remuneration
    When I try to apply
    And I fill expected remuneration with -10000.0
    And I submit application
    Then I should see a message indicating error on expected remuneration
