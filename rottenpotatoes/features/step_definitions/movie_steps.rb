# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(', ').each do |rating|
    if uncheck == 'un'
      step "I uncheck \"ratings_#{rating}\""
    else
      step "I check \"ratings_#{rating}\""
    end
  end
end

Then /I should see movies with ratings: (.*)/ do |rating_list|
  rating_list.split(',').each do |r|
    step "I should see \"#{r}\""
  end
end

Then /I should not see movies with ratings: (.*)/ do |rating_list|
  rating_list.split(',').each do |r|
    step "I should not see \"#{r}\""
  end
end
 
Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  movies_db = Movie.all.map(&:title)
  movies_page = []
  
  page.all('table#movies tbody tr').each do |row|
    movies_page << row.all('td')[0].text
  end

  expect(movies_page).to match_array(movies_db)
end
