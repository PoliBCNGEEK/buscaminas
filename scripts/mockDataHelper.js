const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
const mockData = urlParams.get('mockData');
var board = [];
var numMines;



const countMines = (data) => {
  return data.replace(/[^*]/g, "").length
}


const parseMockDataToString = (data) => {
    let strData = data.split(/\r?\n/).join('-')
    strData = strData.replaceAll(' ', '')
    strData = strData.replaceAll('|', '')
    while (strData[strData.length - 1] === '-') {
      strData = strData.slice(0, -1)
    }
    return strData
  }

  
const createBoardFromMockData = (data) => {
    const board = []
    let mockBoard = data.split('-')
    mockBoard = mockBoard.map((row) => { return row.split('') })
    for (let row = 0; row < mockBoard.length; row += 1) {
      board.push([])
      for (let column = 0; column < mockBoard[0].length; column += 1) {
        board[row].push({
          isMineExploded: false,
          isRevealed: false,
          isWrongTagged: false,
          isFlagged: false,
          isQuestionMarked: false,
          numberOfMinesAround: 0,
          isMine: mockBoard[row][column] === '*'
        })
      }
    }
    console.log('board', board)
    //minefieldNumbering(board)
    return board
  }

