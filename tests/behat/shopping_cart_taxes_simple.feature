@local @local_shopping_cart @javascript

Feature: Admin tax actions in shopping cart.
  In order buy for students
  As an admin
  I configure tax options
  As a cashier
  I buy for a student and see taxes.

  Background:
    Given the following "users" exist:
      | username | firstname  | lastname    | email                       |
      | user1    | Username1  | Test        | toolgenerator1@example.com  |
      | user2    | Username2  | Test        | toolgenerator2@example.com  |
      | teacher  | Teacher    | Test        | toolgenerator3@example.com  |
      | manager  | Manager    | Test        | toolgenerator4@example.com  |
    And the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | user1    | C1     | student        |
      | user2    | C1     | student        |
      | teacher  | C1     | editingteacher |
    And the following "core_payment > payment accounts" exist:
      | name           |
      | Account1       |
    When I log in as "admin"
    And I navigate to "Payments > Payment accounts" in site administration
    Then I click on "PayPal" "link" in the "Account1" "table_row"
    And I set the field "Brand name" to "Test paypal"
    And I set the following fields to these values:
      | Brand name  | Test paypal |
      | Client ID   | Test        |
      | Secret      | Test        |
      | Environment | Sandbox     |
      | Enable      | 1           |
    And I press "Save changes"
    And I should see "PayPal" in the "Account1" "table_row"
    And I should not see "Not available" in the "Account1" "table_row"
    And I visit "/admin/category.php?category=local_shopping_cart"
    And I set the field "Payment account" to "Account1"
    And I set the field "Enable Tax processing" to "checked"
    And I press "Save changes"
    And I set the following fields to these values:
      | Tax categories and their tax percentage | 15 |
    And I press "Save changes"
    Then I should see "Changes saved"
    And the field "Tax categories and their tax percentage" matches value "15"
    And the field "Default tax category" matches value ""
    And I log out

  @javascript
  Scenario: Add single item for user to the shopping cart when tax without categories enabled
    Given I log in as "user1"
    And I visit "/local/shopping_cart/test.php"
    And I wait until the page is ready
    And I click on "#btn-local_shopping_cart-main-4" "css_element"
    And I click on "#nav-shopping_cart-popover-container" "css_element"
    Then I should see "my test item 4" in the "ul.shopping-cart-items" "css_element"
    And I should see "13.94 EUR" in the "#item-local_shopping_cart-main-4 .item-price" "css_element"
    And I should see "(12.12 EUR + 15%)" in the "#item-local_shopping_cart-main-4 .item-price" "css_element"
    And I should see "13.94" in the "li.sc_initialtotal" "css_element"
