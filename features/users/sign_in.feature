Feature: Sign in
In order to get access to protected sections of the site
A user
Should be able to sign in

	@javascript
    Scenario: User is not signed up
		Given I do not exist as a user
		When I sign in with valid credentials
		Then I see an invalid login message
		And I should be signed out

    @javascript
    Scenario: User signs in successfully
    	Given I exist as a user
        And I am not logged in
		When I sign in with valid credentials
		Then I see a successful sign in message
		And I should be signed in

	@javascript
    Scenario: User enters wrong email
		Given I exist as a user
		And I am not logged in
		When I sign in with a wrong email
		Then I see an invalid login message
		And I should be signed out

	@javascript
    Scenario: User enters wrong password
		Given I exist as a user
		And I am not logged in
		When I sign in with a wrong password
		Then I see an invalid login message
		And I should be signed out