Feature: Create Categories
  As an blog admin 
  In order to tag my articles
  I want to be able to create or edit Categories

  Background: 
    Given the blog is set up
    And I am logged into the admin panel

    Scenario: Succesfully create or edit Categories
      Given I am on the 'categories page'
      Then I should see 'Categories'
      And I should see 'Description'




