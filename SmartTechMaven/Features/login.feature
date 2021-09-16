Feature: Login

	As a visitor
	I want to login to my account
	So that I can use exclusive features of the site

	Background: Fake Data for Login
		Given the existing <account_name> and <password>
		| account_name | password   |
		| john.doe     | Qwerty!234 |
		| jane.doe     | Qwerty432! |

	Scenario: Valid Username and Password
		
		When I visit the login page
			And I use "john.doe" as the username
			And I use "Qwerty!234" as the password
		Then I should go to the profile page for my account
			And I should see the message "Welcome John Doe"
			And I should see the logout link on the global navigation
			And I should not see the login link on the global navigation
			And I should not see the create account link on the global navigation

	Scenario: Invalid Username or Password

		When I visit the login page
			And I use "jane.doe" as the username
			And I use "BadPassword" as the password
		Then I should see the error message "Not a valid username or password"
			And I should see the username emphasized
			And I should see the password emphasized

	Scenario: Too Many Incorrect Attempts

		Given I have submitted 4 incorrect logins
		When I visit the login page
			And I use "jane.doe" as the username
			And I use "BadPassword" as the password
		Then I should see the error message "We have locked your account for too many incorrect login attempts"

		
	Scenario: Long Wait Time

		When I visit the login page
			And I use "john.doe" as the username
			And I use "Qwerty!234" as the password
			And the server takes longer than 10 seconds to respond
		Then I should see the error message "Error: The server did not respond"

	Scenario: Internal Server Error

		When I visit the login page/..
			And I use "john.doe" as the username
			And I use "Qwerty!234" as the password
			And the server returns a 500 error code
		Then I should see the error message "Error: There was a server error"
		
		

   
