Feature: Suggested offers on application

  In order to know about suggested offers
  As candidate
  I want to view suggested offers when applicating to an offer

  Background:
    Given "Ruby Web Programmer" offer exists in the offers list with tags "programmer,web,ruby"
    And I access the offers list page

  Scenario: No suggested offers are displayed if no other offers tags matches
    When I apply to "Ruby Web Programmer" offer
    Then I should see 0 suggested offers

  Scenario: Two suggested offers are displayed if only the tags of two offers match
    Given "Python Programmer" offer exists in the offers list with tags "programmer,python"
    And "Whitespace Programmer" offer exists in the offers list with tags "programmer,whitespace"
    When I apply to "Ruby Web Programmer" offer
    Then I should see 2 suggested offers

  Scenario: Three suggested offers are displayed if the tags of three offers match
    Given "Python Programmer" offer exists in the offers list with tags "programmer,python"
    And "Whitespace Programmer" offer exists in the offers list with tags "programmer,whitespace"
    And "Ruby Developer" offer exists in the offers list with tags "ruby"
    When I apply to "Ruby Web Programmer" offer
    Then I should see 3 suggested offers

  Scenario: Three suggested offers are displayed if the tags of more than three offers match
    Given "Python Programmer" offer exists in the offers list with tags "programmer,python"
    And "Whitespace Programmer" offer exists in the offers list with tags "programmer,whitespace"
    And "Ruby Developer" offer exists in the offers list with tags "ruby"
    And "PHP Web" offer exists in the offers list with tags "web,php"
    When I apply to "Ruby Web Programmer" offer
    Then I should see 3 suggested offers

  @wip
  Scenario: A suggested offer is displayed if only the tags of one offer match
    Given "Python Programmer" offer exists in the offers list with tags "programmer,python"
    When I apply to "Ruby Web Programmer" offer
    Then I should see 1 suggested offers
    And Suggested offer link should redirect to suggested offer apply page
