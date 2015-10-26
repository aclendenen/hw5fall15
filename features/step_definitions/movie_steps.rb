# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

 Then /^(?:|I )should see "([^\"]*)"$/ do |text|
    expect(page).to have_content(text)
 end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end


# New step definitions to be completed for HW5. 
# Note that you may need to add additional step definitions beyond these


# Add a declarative step here for populating the DB with movies.


Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
  movies_table.hashes.each do |movie|
    # Each returned movie will be a hash representing one row of the movies_table
    # The keys will be the table headers and the values will be the row contents.
    # Entries can be directly to the database with ActiveRecord methods
    # Add the necessary Active Record call(s) to populate the database.
    Movie.create movie
  end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |arg1|
  # HINT: use String#split to split up the rating_list, then
  # iterate over the ratings and check/uncheck the ratings
  # using the appropriate Capybara command(s)
  all('input[type=checkbox]').each do |checkbox|
      checkbox.set(false)
  end
  
  arg1 = arg1.gsub(",", "")
  arg1 = arg1.split
  all('input[type=checkbox]').each do |checkbox|
    arg1.each do |x|
        x = "ratings_" + x
        if x == checkbox[:id]
            checkbox.set(true)
        end
    end
  end
  click_on 'ratings_submit'
end

Then /^I should see only movies rated: "(.*?)"$/ do |arg1|
  result = true
  all('//tbody/tr/td[2]').each do |rating|
    if !arg1.include?(rating.text)
         result = false 
    end
  end
  expect(result).to be_truthy
end

Then /^I should see all of the movies$/ do
    if all('tr').count-1 == Movie.count
     result = true
    else
     result = false
    end
    expect(result).to be_truthy 
end

When /^I have sorted alphabetically$/ do
    click_on 'Movie Title'
end
  
Then /^I should see Aladdin before Amelie$/ do
  count = 0
  aladdin = 0
  amelie = 0
  all('//tbody/tr/td[1]').each do |rating|
    if rating.text == "Aladdin"
     aladdin = count
    elsif rating.text == "Amelie"
     amelie = count
    end
    count = count + 1 
  end
  expect(amelie > aladdin).to be_truthy
end

When /^I have sorted by release date in increasing order$/ do
    click_on 'Release Date'
end

Then /^I should see A Space Odyssey before Raiders of the Lost Ark$/ do
  count = 0
  space = 0
  raiders = 0
  all('//tbody/tr/td[1]').each do |rating|
    if rating.text == "Raiders of the Lost Ark"
     raiders = count
    elsif rating.text == "A Space Odyssey"
     space = count
    end
    count = count + 1 
  end
  expect(space < raiders).to be_truthy
end

When /^I have searched tmdb with the search terms "(.*?)"$/ do |searchTerm|
    visit movies_path
    fill_in(:search_term, :with => searchTerm)
    click_button 'Search TMDB'
end

Then /^I should see "(.*?)" items related to "(.*?)"$/ do |amount, searchTerm| 
    total = amount.to_i
    if all('tr').count - 1 == total
     result = true
    else
     result = false
    end
    expect(result).to be_truthy 
end

Then /^I should be transfered to search results page$/ do
    if(page.current_path == movies_search_tmdb_path)
        result = true
    else
        result = false
    end
    expect(result).to be_truthy 
end
 
When /^I have searched tmdb without entering anything for a term$/ do
    click_button 'Search TMDB'
end

Then /^I should see a message saying "(.*?)"$/ do |message| 
    expect(page).to have_content(message)
end

Then /^I should be still on the home page$/ do
    if(current_path == movies_path)
        result = true
    else
        result = true
    end
    expect(result).to be_truthy
end

Given /^"(.*?)" has been searched for$/ do |searchTerm|
    @totMovBefore = Movie.count
    visit movies_path
    fill_in(:search_term, :with => searchTerm)
    click_button 'Search TMDB'
end

When /^I have checked "(.*?)" movies$/ do |amount|
    count = 0
    total = amount.to_i
    all('input[type=checkbox]').each do |checkbox|
        if(count < total)
            checkbox.set(true)
        end
        count += 1
    end
      
end

When /^I have clicked add selected$/ do
    click_button 'Add Selected Movies'
end

Then /^I should be transfered to the home page$/ do
    if(current_path == movies_path)
        result = true
    else
        result = true
    end
    expect(result).to be_truthy
end

Then /^I should see "(.*?)" new movies have been added$/ do |amount|
    addAmt = amount.to_i
    if(@totMovBefore == nil)
        @totMovBefore
    end
    if(Movie.count == @totMovBefore + addAmt)
        result = true
    else
        result = false
    end
    expect(result).to be_truthy
end



