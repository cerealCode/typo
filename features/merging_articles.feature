Feature: Merging Articles
  As a blog admin
  In order to classify related content
  I want to be able to merge Articles

 Background: Users, articles and comments exists in the database

  Given the blog is set up

  Given the following users exist:
   | profile_id | login  | name  | password | email              | state  |
   | 2          | user_1 | User1 | 1111111  | user_1@example.com | active |
   | 3          | user_2 | User2 | 2222222  | user_2@example.com | active |

  Given the following articles exist:
   | id | title    | author | user_id | body     | allow_comments | published | published_at        | state     | type |
   | 3  | Article1 | user_1 | 2       | Content_A | true           | true      | 2013-24-08 22:30:00 | published | Article |
   | 4  | Article2 | user_2 | 3       | Content_B | true           | true      | 2013-24-08 23:00:00 | published | Article |

  Given the following comments exist:
   | id | type    | author | body      | article_id | user_id | created_at          |
   | 1  | Comment | user_1 | Comment_A | 3          | 2       | 2013-24-08 23:31:00 |
   | 2  | Comment | user_1 | Comment_B | 4          | 3       | 2013-24-08 24:01:00 |

Scenario: An admin can merge articles
  Given I am logged in as "admin" with pass "aaaaaaaa"
  And I am on the Edit Page of Article with id 3
  Then I should see "Merge Articles"
  When I fill in "merge_with" with "4"
  And I press "Merge"
  Then I should be on the admin content page
  And I should see "Articles successfully merged!"

Scenario: A non-admin cannot merge articles
  Given I am logged in as "user_1" with pass "1111111"
  And I am on the Edit Page of Article with id 3
  Then I should not see "Merge Articles"

Scenario: The merged article should contain the text of both previous articles
  Given the article with ids "3" and "4" were merged
  And I am on the home page
  Then I should see "Article1"
  When I follow "Article1"
  Then I should see "Content_A"
  And I should see "Content_B"

Scenario: The merged article should have one author (either one of the originals)
  Given the article with ids "3" and "4" were merged
  Then "User1" should be author of 1 articles
  And "User2" should be author of 0 articles

Scenario: The merged article should carry the comments of both previous articles
  Given the article with ids "3" and "4" were merged
  And I am on the home page
  Then I should see "Article1"
  When I follow "Article1"
  Then I should see "Comment_A"
  And I should see "Comment_B"

Scenario: The title of the merged article shoud be the title from either one of the originals
  Given the article with ids "3" and "4" were merged
  And I am on the home page
  Then I should see "Article1"
  And I should not see "Article2"