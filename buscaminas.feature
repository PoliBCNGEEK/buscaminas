Feature: Minesweeper

'Cell (x,y) means row = x, colum = y

Cell with bomb = *
Cell without bomb = o


Cell revealed = #
Cell flagged = !
Cell suspected = ?


Cell with 1 adjacent bomb = 1
Cell with 2 adjacent bomb = 2
Cell with 3 adjacent bomb = 3
Cell with 4 adjacent bomb = 4
Cell with 5 adjacent bomb = 5
Cell with 6 adjacent bomb = 6
Cell with 7 adjacent bomb = 7
Cell with 8 adjacent bomb = 8'


Background: 
Given the user opens the app

Scenario: Default display screen
Then it should display one mine counter---------------------------------------------------------------------------
And a reset button
And a time counter
And a flag counter
And a grid(x,x) with cells ready for the users interactions / enable

Scenario: Right clicking a bomb / reveal ---------------------------------------------------------------convertir en test
Given tthe user loads "*o"
When the user revesl the cell "1-1"
Then the user loses the game

Scenario: Loses game
Given the user right clicks a mine
Then all the mines are revealed and the mine
And the mine that was revealed first changes to a red one

Scenario Outline: Reavealing a cell without mine, showing the number of surrounding mines
Given the user loads "<MockData>"
When the user clicks an empty "cell"
Then the cell should display a "number"

Examples:
|layoutInput|cell|number|
|ooo-ooo-ooo|2-2 |0     |
|ooo-*oo-ooo|2-2 |1     |
|ooo-*o*-ooo|2-2 |2     |
|**o-*oo-ooo|2-2 |3     |
|***-*oo-ooo|2-2 |4     |
|***-*o*-ooo|2-2 |5     |
|***-*o*-*oo|2-2 |6     |
|***-*o*-**o|2-2 |7     |
|***-*o*-***|2-2 |8     |

Scenario: Revealling an empty cell; without mine and without any surrounding mine
Given the user loads "ooo-ooo-ooo"
When the user reveal the cell "2-2"
Then the cell should display as empty

Scenario: Revealling an empty cell: The surrounding cells must be revealed
Given the user loads "ooo-ooo-ooo"
When the user reveal the cell "2-2"
Then the board status should be: "###-###-###"

Scenario: An empty cell revelead by a neightboard, again, the surrounding mines must be revealed

Scenario: Flagging all the mines
Given the users has only one mine without flagged
When the users flags the last mine
Then the users wins

Scenario: Wins game
Given the user wins the game
Then the reset button changes to a smile

Scenario Outline: Right clicking an empty cell without adjacent mines---poner mas informacion en given y when antes que then
Given the user loads "<MockData>"
When the user clicks an empty "<cell>"
Then the adjacent cells get revealed until they have an adjacent cell 
with a mine and then they get a number, with the number of mines they have adjacent

Examples:
|      MockData     |cell|    OutputLayout   |
|oooo-o*oo-oooo-oooo|1,1 |#1oo-1ooo-oooo-oooo|
|oooo-oooo-*o**-o**o|1,2 |####-1211-oooo-oooo|
|oooo-oooo-oo*o-oooo|1,1 |###1-##2o-#1oo-#1oo|
|oooo-oooo-oooo-ooo*|1,1 |####-####-##11-##1o|



Scenario: Left clicking a cell
Given there is a non-interacted cell
When the user left clicks the cell
Then the cell changes to  flagged "!"

Scenario: Left clicking a cell already flagged
Given there is a cell that is flag
When the user left clicks the cell
Then the cell changes to an interrogated cell

Scenario:Left clicking a cell with a question
Given there is a cell with a question
When the user left clicks the cell
Then the cell changes to a non-interacted cell

Scenario Outline: The users uses too many flags and the flag counter becomes negative----------utilizar mockdata pequeño
Given the "<flagCounter>"
When the users puts another flag
Then the counter goes negative until the users removes some 
the flags until there's only 10

Examples:
|number of flags| flagCounter |
|10             |0            |
|9              |1            |
|0              |10           |
|15             |-5           |
|20             |-10          |
|1              |9            |


Scenario: The timer runs
Given there is a timer being null
When the user interacts with a cell
Then goes to 0 and the timer goes up for every second it passes

Scenario: The user interacts with the reset button
Given the user loads the default layout
When the user interacts with the reset button
Then the game restarts 

Scenario: Sad face
Given the user interacts with a mine
Then the "<resetButton>" changes to "<sadFaceResetButton>"

Scenario: Happy face 
Given the user flags every mine
Then the "<restButton>" changes to "<happyFaceResetButton>"

Scenario: flag counter








