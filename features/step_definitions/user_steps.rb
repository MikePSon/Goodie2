### UTILITY METHODS ###

def create_visitor
  @visitor ||= { :first_name => "Testy", :last_name => "McQAface", :email => "programadmin@testqa.com",
    :password => "Goodie!@3qwe", :password_confirmation => "Goodie!@3qwe", :program_admin => "true" }
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "signupInputFirstName", :with => @visitor[:first_name]
  fill_in "signupInputLastName", :with => @visitor[:last_name]
  fill_in "signupInputEmail", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  #Hack for stripe
  page.evaluate_script("$('#user_subscribed').prop('checked', false)")
  click_button "submit_button"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Sign in"
end

### GIVEN ###
Given /^I am not logged in$/ do
  current_driver = Capybara.current_driver
  Capybara.current_driver = :rack_test
  page.driver.submit :delete, "/users/sign_out", {}
  Capybara.current_driver = current_driver
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  find("#dropdown_container").click
  click_link "sign_out_btn"
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  find("#dropdown_container").click
  click_link "Edit Account"
  fill_in "user_first_name", :with => "Testy"
  fill_in "user_first_name", :with => "McNewName"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "submit_button"
end

When /^I look at the list of users$/ do
  visit '/'
end

### THEN ###
Then /^I should be signed in$/ do
  page.should_not have_content "Sign up"
  page.should_not have_content "Sign in"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign in"
  page.should_not have_content "Sign out"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should be able to select my plan$/ do
  page.should have_content "Select your plan!"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "setup your organization within Goodie"
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password confirmation doesn't match Password"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password confirmation doesn't match Password"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid Email or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "Your account has been updated successfully."
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:name]
end
