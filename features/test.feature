Feature: Default User Avatar
	If a user does not have a default portrait set, the system will display an avatar displaying the first name initial and last name initial. For the User Test Test, the avatar will be TT.

	Scenario: Default Avatars should use the first name and last name initials
		Given I open the browser to "http://localhost:9080/"
		When I click the "Sign In" link
		And I enter "test@liferay.com" into the "Email Address" input field
		And I enter "rest" into the "Password" input field
		And I check the "Remember Me" checkbox
		And I click the "Sign In" button
		Then I should see the default avatar displaying "TT"