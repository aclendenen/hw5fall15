Feature: add movie(s) from tmdb search

  As an avid moviegoer
  So that I can add movies easier 
  I want to add movies from a TMDB search

Background: I am on the serch results of Harry Potter

  Given I am on the RottenPotatoes home page
  And "Harry Potter" has been searched for
 
Scenario: Add one movie from the search results
  When I have checked "1" movies 
  And I have clicked add selected 
  Then I should be transfered to the home page
  Then I should see a message saying "Movie successfully added to Rotten Potatoes"
  Then I should see "1" new movies have been added
  
Scenario: Add multiple movies from the search results
  When I have checked "3" movies 
  And I have clicked add selected 
  Then I should be transfered to the home page
  Then I should see a message saying "Movies successfully added to Rotten Potatoes"
  Then I should see "3" new movies have been added
  
Scenario: Click add selected without selecting any movies
  When I have clicked add selected 
  Then I should be transfered to the home page
  Then I should see a message saying "No movies selected"
  Then I should see "0" new movies have been added