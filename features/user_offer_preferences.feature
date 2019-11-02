Feature: User Offer prefered tags
  In order to be notified about new offers
  As an user
  I want application to notify me when a new offer is activated with my prefereds

  Scenario: Registration with 10 prefered tags
    Given I access to the register page
    When I try to register with prefered tags "python,ruby,web,developer,programmer,whitespace,basic,c,cpp,devops"
    And I try to register
    Then I should be registered succesfully
  @wip
  Scenario: Registration with more than 10 prefered tags
    Given I access to the register page
    When I try to register with prefered tags "python,ruby,web,developer,programmer,whitespace,basic,c,cpp,devops,java"
    And I try to register
    Then I should see a message indicating error on prefered tags
  @wip
  Scenario: Notification on job offer activation with matching prefered tags
    Given User "notified@test.com" is registered with prefered tags "developer,python"
    And "Web Programmer" offer exists in the offers list with tags "ruby,developer"
    When Job Offer is first time activated
    Then User receive email with Job Offer info
  @wip
  Scenario: Notification sent just on first job offer activation
    Given User "notified2@test.com" is registered with prefered tags "net"
    And "Net Developer" offer exists in the offers list with tags "net,developer"
    And Job Offer was already activated
    When Job Offer is deactivated
    And Job Offer is activated
    Then User should not receive an email with Job Offer info
  @wip
  Scenario: No notification email is sent when tags not matches
    Given User "no_notified@test.com" is registered with prefered tags "php"
    And "Java Developer" offer exists in the offers list with tags "java,developer"
    When Job Offer is first time activated
    Then User should not receive an email with Job Offer info
