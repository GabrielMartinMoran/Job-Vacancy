Feature: Add tags to offers
  In order to classify my offers
  As a job offerer
  I want to add tags to my offers

Background:
  Given I am logged in as job offerer
  And I access the new offer page

Scenario: Create new offer without tags
  When I fill the title with "Programmer vacancy"
  And I fill the tags with ""
  And confirm the new offer
  Then I should see "Offer created"
  And I should see "" in tags field for "Programmer vacancy" in My Offers

Scenario: Create new offer with 3 tags
  When I fill the title with "Multiparadigm programmer vacancy"
  And I fill the tags with "Python3, Basic, Whitespace"
  And confirm the new offer
  Then I should see "Offer created"
  And I should see "python3,basic,whitespace" in tags field for "Multiparadigm programmer vacancy" in My Offers

Scenario: Create new offer with 1 tag
  When I fill the title with "Algol programmer vacancy"
  And I fill the tags with "ALGOL 58"
  And confirm the new offer
  Then I should see "Offer created"
  And I should see "algol58" in tags field for "Algol programmer vacancy" in My Offers

Scenario: Create new offer with 4 tags
  When I fill the title with "Programmer vacancy"
  And I fill the tags with "ALGOL 58, Python3, Basic, Whitespace"
  And confirm the new offer
  Then I should see a message indicating that there is too much tags
@wip
Scenario: Create new offer with 4 tags repeating 1 tag
  When I fill the title with "Agile programmer vacancy"
  And I fill the tags with "Ruby, Cucumber, Agile, Ruby"
  And confirm the new offer
  Then I should see "Offer created"
  And I should see "ruby,cucumber,agile" in tags field for "Agile programmer vacancy" in My Offers
@wip
Scenario: Create new offer with 2 same tags but with different casing
  When I fill the title with "JavaScript programmer vacancy"
  And I fill the tags with "JavaScript, jAvAsCrIpT"
  And confirm the new offer
  Then I should see "Offer created"
  And I should see "javascript" in tags field for "JavaScript programmer vacancy" in My Offers