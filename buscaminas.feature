Feature: Buscaminas

Background: 
Given the user opens the app

Scenario: Default display screen
Then it should display one mine counter, a reset button, a time counter and a grid(x,x) with buttons ready for the users interactions 

Scenario Outline: Right clicking one button 
Given the button is in the state of: "<InitialButtonState>"
When the user presses the "<button>"
Then the button should change to a state: "<PostButtonState>"


Examples:
|button|InitialButtonState|PostButtonState|
|1x1   |Mine             |Mine           |
|1x1   |Blank            |Blank          |
|1x1   |Blank            |Number 1       |
|1x1   |Blank            |Number 2       |
|1x1   |Blank            |Number 3       |


Scenario Outline: Right Clicking one button that is a mine
Given there is a button with a "<PostButtonState>" is "<mine>"
When the user clicks that button
Then the "<GameState>" changes to "<Over>"
And  all the mines get revealed

Examples:
|PostButtonState|GameState|
|mine           |Over     |

Scenario Outline: Number of mines
Given the user started the GameState
Then it sgould display a grid (x,x) with a relation of ((xx)/mines = 6,4)------------------------------------------------------------------------

Examples:
|grid  |Number of Mines|
|88   |10             |
|16*16 |40             |


Scenario Outline: Left Clicking one button
Given the "<GameState>" != "<Over>" 
When the user left clicks a button with a "<ButtonState>" = "<No interaction>"
Then the "<Button State>" should change to "<Flaged>"

Examples: