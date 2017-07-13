Feature: Cycle Creation
In order to successfully use the application
A program administrator
Should be able to create my organization, projects, and cycles

	@javascript
	Scenario: User creates and manually opens a cycle
		Given I am a striped user
		And I open a cycle early
		Then I should receive an successful update notice