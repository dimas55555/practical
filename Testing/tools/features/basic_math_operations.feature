Feature: Basic Math Operations
  As a user
  I want to perform basic math operations
  So that I can use a calculator

  Scenario: Addition
    Given I have entered 1 into the calculator
    And I have entered 1 into the calculator
    When I press add
    Then the result should be "2" on the screen

  Scenario: Subtraction
    Given I have entered 4 into the calculator
    And I have entered 2 into the calculator
    When I press subtract
    Then the result should be "0" on the screen

  Scenario: Multiplication
    Given I have entered 3 into the calculator
    And I have entered 3 into the calculator
    When I press multiply
    Then the result should be "9" on the screen

  Scenario: Division
    Given I have entered 4 into the calculator
    And I have entered 2 into the calculator
    When I press divide
    Then the result should be "1" on the screen
