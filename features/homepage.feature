Feature: Home Page
In order to test Home Page of application
As a Registered user
I want to specify the features of home page

	Scenario: Home Page Sign In
		When I go to the homepage
		Then I should be able to signin
	
	Scenario: Home Page Sign Up
		When I go to the homepage
		Then I should be able to signup
	
	Scenario: Home Page Analytics
		When I go to the homepage
		Then I should be able to learn about analytics
	
	Scenario: Home Page Cycles
		When I go to the homepage
		Then I should be able to learn about cycles
	
	Scenario: Home Page Organizations
		When I go to the homepage
		Then I should be able to learn about organizations

	Scenario: User clicks Sign In
		Given I am on the homepage
		When I click Sign In
		Then I should see the sign in page

	Scenario: User clicks Sign Up
		Given I am on the homepage
		When I click Sign Up
		Then I should see the registration page