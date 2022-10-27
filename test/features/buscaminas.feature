Feature: Minesweeper

'Cell (x,y) means row = x, colum = y

Cell with bomb = *
Cell without bomb = o


Cell revealed = #
Cell mined = !
Cell suspected = ?
Hidden cell "."


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

@done
Scenario: Display time counter is empty by default
Then the time counter should be empty 

@done
Scenario: Display flag counter by default shows the amount of mines
Given the user loads the following mock data: "*ooo-*ooo"
Then the flag counter should be "2"

# cambiar !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Scenario: Display minefield, validate the initial dimensions
Given the user loads the following mock data: "<board>"
Then the minefield should have "<rows>" rows
And the minefield should have "<columns>" columns

Examples:
| board      | rows | columns |
| *ooo-*ooo  | 2    | 4       |
| ***-**o-ooo| 3    | 3       |

@manual
Scenario: The timer runs when the game starts
When the game is starts
Then the timer should update the time for every second it passes

@done
Scenario: interacting with a cell with bomb, game is lost 
Given the user loads "*o"
When the user reveals the cell "0-0"
Then the user loses the game

Scenario: When the game is over, highlight the exploded mine
Given the user loads "*o"
When the user reveals the cell "0-0"
Then the cell "0-0" should be highlighted

@wip
Scenario: When the game is over, all the mines should be revealed
Given the user loads "*o-**"
When the user reveals the cell "0-0"
Then the cell "0-0" should show a mine
And the cell "1-0" should show a mine
And the cell "1-1" should show a mine

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

Scenario: If the user thinks that doesn't have enough information to determine if under a cell there is a mine, it can be tagged as uncertain
When the user tags the cell with as uncertain 1,1
Then the cell 1,1 should show an uncertain symbol

Scenario: If the user change the opinion about a cell tagged as mined, it can be untagged
When the user untags the cell with as mined 1,1
Then the cell 1,1 should not show a mined symbol

Scenario: If the user change the opinion about a cell tagged as uncertain, it can be untagged
When the user untags the cell with a uncertain 1,1
Then the cell 1,1 should not show an uncertain symbol

Scenario Outline: Tagging cells with right click                         
Given: the user tags the cell 1,1 as "<initialTag>"
when: the user right clicks the cell 1,1
Then: the cell 1,1 should be tagged as "<finalTag>"

Examples:
|initialTag     | finalTag    |
| none          | mined       |
| mined         | uncertain   |
| uncertain     | none        |

Scenario: If the user tags as mined then the mine the counter goes down
Given the flag counter is "10"
When the user tags as mined the cell "1-1"
Then the flag counter should be "9"

Scenario: The user uses too many mined tags and the flag counter becomes negative
Given the user loads "*oo"
And the user tags as mined the cell "1-2"
And the flag counter is "0"
When  the user tags as mined the cell "1-1"
Then the flag counter should be "-1"

Scenario: The game starts when the user reveals a cell
When the user reveals a cell
Then the game starts

Scenario: The game starts when the user tags a cell
When the user tags a cell
Then the game starts

Scenario: The user reset the game, the game must be initialized
Given the user loads
"""  
ooo
***
ooo
*o*
"""
And the user discover the cell(1,1)
And the user tags as mined the cell (2,1)
And the user tags as uncertain the cell (3,1)
When the user resets
Then all the cells should be hidden
And  all the cells shouldn't show a tag
And all the cells should be enabled
And the counter should be 10
And the timer should be empty

Scenario: The user reset the game, using the mouse
Given the user loads
"""  
ooo
***
ooo
*o*
"""
And the user discover the cell(1,1)
And the user tags as mined the cell (2,1)
And the user tags as uncertain the cell (3,1)
When the user left clicks in the face button ????
Then game should be reset