Feature: Minesweeper

'Cell (x,y) means row = x, colum = y

Cell with bomb = *
Cell without bomb = o


Cell revealed = #
Cell flagged = !
Cell suspected = ?
Hiden cell "."


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

Scenario: Display time counter is empty by default
Then the time counter should be empty 

Scenario Outline: Display flag counter by default shows the amount of mines
Given the user loads the following mock data: "<board>"
Then the flag counter should be "<counter>"

Examples:
| board      | counter |
| *ooo-*ooo  | 2       |
| ***-**o    | 5       |

Scenario: Display minefield, validate the initial dimensions
Given the user loads the following mock data: "<board>"
Then the minefield should have "<rows>" rows
And the minefield should have "<columns>" columns

Examples:
| board      | rows | columns |
| *ooo-*ooo  | 2    | 4       |
| ***-**o-ooo| 3    | 3       |


Scenario: interacting with a cell with bomb, game is lost 
Given the user loads "*o"
When the user reveals the cell "1-1"
Then the user loses the game

Scenario: When the game is over, highlight the exploded mine
Given the user loads "*o"
When the user reveals the cell "1-1"
Then the cell "1-1" should be highlighted

Scenario: When the game is over, all the mines should be revealed
Given the user loads "*o-**"
When the user reveals the cell "1-1"
Then the cell "2-1" should show a mine
And the cell "2-2" should show a mine

Scenario Outline: Revealing a cell without mine, showing the number of surrounding mines
Given the user loads "<MockData>"
When the user clicks an empty "2-2"
Then the cell should display a "number"

Examples:
|layoutInput|number|
|ooo-ooo-ooo|0     |
|ooo-*oo-ooo|1     |
|ooo-*o*-ooo|2     |
|**o-*oo-ooo|3     |
|***-*oo-ooo|4     |
|***-*o*-ooo|5     |
|***-*o*-*oo|6     |
|***-*o*-**o|7     |
|***-*o*-***|8     |

Scenario: Revealing an empty cell; without mine and without any surrounding mine
Given the user loads
"""
ooo
ooo
ooo
***
"""
When the user reveal the cell "2-2"
Then the cell should display as "empty"

Scenario: Revealing an empty cell: The surrounding cells must be revealed
Given the user loads
"""
ooo
ooo
ooo
***
"""
When the user reveal the cell "2-2"
Then the board status should be:
"""
###
###
232
...
"""

Scenario: Empty cell reveled by a neighbor: The surrounding cells must be revealed
Given the user loads
"""  
oooooo
oooooo
oo*ooo
o*oooo
"""
When the user reveal the cell "1-1"
Then the minefield should looks like:
"""  
######
#111##
12.1##
...1##
"""

Scenario: Tagged as mined all the mines, wins the game    
Given the users has only one mine without being tagged
When the users tags as mined the last mine
Then the users wins

Scenario: Wins game, reset button changes state
Given the user wins the game
Then the reset button changes to a smile

Scenario: If the user thinks there's a cell with a mine, it can be tagged as mined
When the user tags the cell with as mined 1,1
Then the cell 1,1 should show a mined symbol

Scenario: If the user thinks the mine tagged as uncertain has no longer a mine, he can eliminate the tag  
When the user try to mark again the already tagged as uncertain mine 1,1
Then the cell 1,1 returns to a hidden cell

Scenario: Tagging cells with right click                         
Given: the user tags the cell 1,1 as "<initialTag>"
when: the user right clicks the cell 1,1
Then: the cell 1,1 should be tagged as "<finalTag>"

Examples:
|initialTag     | finalTag    |
| none          | mined       |
| mined         | uncertain   |
| uncertain     | none        |

Scenario Outline: The users uses too many flags and the flag counter becomes negative
Given the user loads "*oo"
And the user tags as mined the cell "1-2"
And the flag counter is "0"
When  the user tags as mined the cell "1-1"
Then the flag counter should be "-1"

Scenario Outline: If the user tags as mined a mine the counter goes down
Given the counter is the number of mines
When the user tags as mined a cell
Then the counter goes down

Scenario: The game starts when the user interacts with a cell
Given the user loads the game
When the user interacts in any form with a cell
Then the game starts
@manual
Scenario: The timer runs when the game starts
When the game is starts
Then the timer should update the time for every second it passes

Scenario: The user reset the game, the game must be initialized
Given the user loads
"""  
######
#111##
12?1##
!..1##
"""
When the user resets
Then the board status should looks like:
"""  
......
......
......
......
"""
