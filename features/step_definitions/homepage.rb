When(/^I go to the homepage$/) do
  visit root_path
end

Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I click Sign In$/) do
  click_on "Sign_In"
end

When(/^I click Sign Up$/) do
  click_on "Sign_Up"
end

Then(/^I should see the sign in page$/) do
  expect(page).to have_content("Please enter your email and password")
end

Then(/^I should see the registration page$/) do
  expect(page).to have_content("Register today!")
end

Then(/^I should be able to signup$/) do
  expect(page).to have_content("Sign up")
end

Then(/^I should be able to signin$/) do
  expect(page).to have_content("Sign in")
end

Then(/^I should be able to learn about analytics$/) do
  expect(page).to have_content("Track how your foundation has been performing over time.")
end

Then(/^I should be able to learn about cycles$/) do
  expect(page).to have_content("Cycles")
end

Then(/^I should be able to learn about organizations$/) do
  expect(page).to have_content("Keep an accurate tab on your history, see how you grow with Goodie")
end