Feature: search tmdb

Scenario: search tmdb with a valid string that gives one result
  When I am on the RottenPotatoes home page
  And I have searched tmdb with the search terms "Austin Powers in Goldmember"
  Then I should be transfered to search results page
  Then I should see "1" items related to "Austin Powers in Goldmember"
 
Scenario: search tmdb with a valid string that gives multiple results
  When I am on the RottenPotatoes home page
  And I have searched tmdb with the search terms "Harry Potter"
  Then I should be transfered to search results page
  Then I should see "15" items related to "Harry Potter"
  
Scenario: search tmdb with the invalid search of blank spaces
  When I am on the RottenPotatoes home page
  And I have searched tmdb with the search terms "  "
  Then I should be still on the home page
  Then I should see a message saying "Invalid search term"
  
Scenario: search tmdb without entering anything to search
  When I am on the RottenPotatoes home page
  And I have searched tmdb without entering anything for a term
  Then I should be still on the home page
  Then I should see a message saying "Invalid search term"