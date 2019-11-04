Feature: Job Offer max valid date
  In order to do not let applicants to apply in my old offers
  As a job offerer
  I want to define max valid date to my offers

  Background:
    Given I am logged in as job offerer
  @wip
  Scenario: Specify max valid date in my offer
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    And And I fill max valid date with "tomorrow" date
    And confirm the new offer
    Then I should see "Programmer vacancy" in Offers list
  @wip
  Scenario: Offer with max valid date older than today is not listed in job offers list
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    And And I fill max valid date with "yesterday" date
    And confirm the new offer
    Then I should not see "Programmer vacancy" in Offers list
  @wip
  Scenario: Offer with max valid date older than today is marked as expired in my offers
    Given I access the new offer page
    When I fill the title with "Programmer vacancy"
    And And I fill max valid date with "yesterday" date
    And confirm the new offer
    Then I should see a label "expired" in my offers for this offer
  @wip
  Scenario: Offer with expired date is not showed in suggested offers
    Given "Ruby Web Programmer" offer exists in the offers list with tags "programmer,web,ruby"
    And I access the new offer page
    When I fill the title with "Programmer vacancy"
    And I fill the tags with "programmer,web,ruby"
    And And I fill max valid date with "yesterday" date
    And confirm the new offer
    And I try to access to "Ruby Web Programmer" the offer page
    Then I should see 0 suggested offers
  @wip
  Scenario: Try to apply to an expirated offer
    Given I access the new offer page
    When I fill the title with "Expired Programmer vacancy"
    And And I fill max valid date with "yesterday" date
    And confirm the new offer
    And I try to access to "Expired Programmer vacancy" the offer page
    Then I should see a message indicating expired offer
