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

Scenario: Empty cell reveled by a neighbor: The surrounding cells must be revealed !!!!!!!!!!poner mas columnas
Given the user loads
"""  
ooo
ooo
oo*
o*o
"""
When the user reveal the cell "1-1"
Then the minefield should looks like:
"""  
###
#11
12.
...
"""

Scenario: Flagging with ! all the mines, wins the game     !!!!conceptos
Given the users has only one mine without flagged
When the users flags  with ! the last mine
Then the users wins

Scenario: Wins game, reset button changes state
Given the user wins the game
Then the reset button changes to a smile

Scenario: If the user thinks there's a cell with a mine, it can be tagged as mined   !!!!conceptos
When the user tags the cell with as mined 1,1
Then the cell 1,1 should show a mined symbol

Scenario: Right clicking a cell, tagging as mined
When the users rights clicks the 1,1 cell
Then the cell 1,1 should be tagged as mined

Scenario: Right clicking a cell already flagged with ! flags it with a ?  !!!!conceptos ? = tagged as uncertain
Given there is a cell 1,1 already flagged with a !
When the user right clicks the cell 1,1
Then the cell should be flagged with a ?

Scenario: If the user thinks the flagged with ? has no longer a mine, he can eliminate the flag !!!!conceptos ? = tagged as uncertain
When the user try to mark again the already flagged with a ? mine 1,1
Then the cell 1,1 returns to a hidden cell

Scenario: Right clicking a cell already flagged with ? eliminates the flag !!!!conceptos ? = tagged as uncertain
Given there is a cell 1,1 already flagged with a ?
When the user right clicks the cell 1,1
Then the cell should return to a hidden cell

Scenario: Tagging cells with right click  !!!!revisar
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

Scenario Outline: Flag counter   !!!poner concepto y explicarlo
Given the user loads "<MockData>"
When the user interacts putting a flag
Then the "<flagCounter>" goes down from 10

Examples:
|      MockData     |flagCounter|
|o!!!-o*!!-!!o!-!!oo|0          |
|o!!!-o*!!-!!o!-!!oo|-1         |
|oooo-oooo-!!!!-oooo|6          |
|oooo-oooo-!!!!-!!!!|2          |
|oooo-oooo-oooo-o!oo|9          |

  # escenarios de cuando inicia una partida !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  # destapa una celda -> empieza partida (o la pierde directamente)
  # pone un tag a una celda -> empieza partida

@manual
Scenario: The timer runs when the game starts
When the game is starts
Then the timer should update the time for every second it passes

Scenario: The user reset the game, the game must be initialized
# load mock
# destapar un par de celdas
# poner un par de tags, uno de cada tipo
When the user resets
Then 
# todas las celdas estan tapadas
todas las celdas estan activas
ningunga celda está tageada
el contador vale ???
el timer es empty 

Scenario: The user rests the game, using the reset button
# load mock
# destapar un par de celdas
# poner un par de tags, uno de cada tipo
When the user clicks the reset button
Then the game restarts 