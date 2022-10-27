function gameData(){
    var game = {}
    game.state = "";
    game.smile = "normal";
    game.height = 8;
    game.width = 8;
    game.numMines = 10;
    game.timer = "0";
    return game;
}
var board = [];
const obj = gameData();
smile();

function addEventClick() {
    var ejes = [];
    var cell;
    let cells = document.getElementsByTagName("td");
    for (const element of cells) {
        element.addEventListener('mousedown', (Event) => {
            if(Event.button==0){
                console.log(element.getAttribute("id"));
                ejes = element.getAttribute("id").split('-');
                cell = board[ejes[0]][ejes[1]];
                if(cell.isMine){
                    updateCell(cell,"isMineExploded",true);
                    revealMine(ejes[0],ejes[1]);
                    revealAllMines();
                    obj.state="lost";
                    smile();
                }else{
                    uncoverCell(ejes[0],ejes[1]);
                }
            }else if(Event.button==2){
                ejes = element.getAttribute("id").split('-');
                 flagCell(ejes[0],ejes[1]);
            }
        });
        element.addEventListener('contextmenu', (Event) => {
            Event.preventDefault();
        });
    }

}

function getID() {
    var cellInfo; 
    return getElementById(cell)
}

document.addEventListener('DOMContentLoaded', () => 
{
    if(window.location.search.includes('?')){
        obj.numMines = countMines(mockData);
        board = createBoardFromMockData(mockData);
        generateTable(board.length,board.length);
        
    }else{
        minefieldCreation();
        generateTable(obj.height,obj.width);
        randomMines();
    }
    addEventClick();
    adjacentMinesCount();
    flagCounter();
})

function randomMines(){
    const numSpaces = obj.height*obj.width;
    var mines = [];
    var numMinesPositioned = 0;
    var numRandom1 = 0;
    var numRandom2 = 0;
    while(numMinesPositioned!=obj.numMines){
        numRandom1 =  Math.floor(Math.random()*((obj.height)-1));
        numRandom2 =  Math.floor(Math.random()*((obj.width)-1));
        if(!board[numRandom1][numRandom2].isMine){
            board[numRandom1][numRandom2].isMine=true;
            numMinesPositioned++;
        }
    }
}

function flagCounter(){
    var flagCounter = document.getElementById("flag-counter");
    flagCounter.innerText = obj.numMines;
}

//falta poner empieze cuando haces click en una mina
var iter = 0;
function counter() {
    var timer = document.getElementById("timer");

    timer.innerText = iter;
    console.log('show at ' + (iter++));
    setTimeout(counter, 999);
  }
  
function minefieldCreation(){
    for (let i = 0; i < obj.height; i++){
        board.push([])
            for (let j = 0; j < obj.width; j++){
                board[i].push({
                isMineExploded: false,
                isRevealed: false,
                isWrongTagged: false,
                isFlagged: false,
                isQuestionMarked: false,
                numberOfMinesAround: null,
                isMine: false
                })
            }
    }
    console.log(board);
}

function generateTable(height,width){
    var table = document.getElementById("table");
    for (let i = 0; i < height; i++){
        var row = document.createElement("tr");
        row.setAttribute("id","row:"+i);
        for (let j = 0; j < width; j++){
            var cell = document.createElement("td");
            var dataTestId = i+"-"+j;
            var id = i+"-"+j;
            var classCell= "cell";
            cell.classList.add(classCell);
            cell.setAttribute("id",id);
            cell.setAttribute("data-testid",dataTestId);
            row.appendChild(cell);
        }
        table.appendChild(row);
    }
}


function smile(){
    var src = document.getElementById("smile");
    if(obj.state === ""){
        
    }else if(obj.state === "lost"){
        src.src = ("/img/smile-sad.png");
    }else{
        src.src = ("/img/smile-happy.png");
    }
}

function revealMine(row,col){
    var cell = document.getElementById(row+"-"+col);
    updateCell(board[row][col],"isRevealed",true);
    cell.classList.add("cellMine");
    cell.classList.remove("cell");
}

function revealAllMines(){
    for (let i = 0; i < obj.height; i++){
        for (let j = 0; j < obj.width; j++){
            if(board[i][j].isMine){
                revealMine(i,j);
            }
        }
    }
}
function flagCell(row, col){
    var cell = document.getElementById(row+"-"+col);
    var cellData = board[row][col];
    if(cellData.isFlagged){
        questionCell(row,col);
    }else if(cellData.isQuestionMarked){
        hiddenCell(row,col);
    }else{
        updateCell(cellData,"isFlagged",true);
        cell.classList.add("flagCell");
        cell.classList.remove("cell");
    }
}
function questionCell(row, col){
    var cell = document.getElementById(row+"-"+col);
    updateCell(board[row][col],"isQuestionMarked",true);
    updateCell(board[row][col],"isFlagged",false);
    cell.classList.add("questionCell");
    cell.classList.remove("flagCell");
   
}
function hiddenCell(row, col){
    var cell = document.getElementById(row+"-"+col);
    updateCell(board[row][col],"isQuestionMarked",false);
    cell.classList.add("cell");
    cell.classList.remove("questionCell");
}

function updateCell(cell,property,value){
    cell[property] = value;
}
function adjacentMinesOfCell(row,col){
    var num = 0;
    var cell;
    for (let i = row-1; i <= row+1; i++){
        for (let j = col-1; j <= col+1; j++){
            if(i>=0 && i<board.length && j>=0 && j<board[i].length){
                cell = board[i][j];
                if(cell.isMine){
                    num++;
                }
            }

        }
    }
    return num;
}

function adjacentMinesCount(){
    var cell;
    for (let i = 0; i < board.length; i++){
        for (let j = 0; j < board[i].length; j++){
            cell = board[i][j];
            if(!cell.isMine){
                cell.numberOfMinesAround = adjacentMinesOfCell(i,j);
            }
        }
    }
}

function uncoverCell(row,col){
    var cell = document.getElementById(row+"-"+col);
    var cellData = board[row][col];
    cell.classList.add("num"+cellData.numberOfMinesAround+"Cell");
    cell.classList.remove("cell");
    updateCell(cellData,"isRevealed",true);
    if(cellData.numberOfMinesAround === 0 && !cell.isMine){
        uncoverNeighbours(row,col);
    }

}

function uncoverNeighbours(row,col){
    var cell;
  for (let i = row - 1; i <= row + 1; i++) {
    for (let j = col - 1; j <= col + 1; j++) {
        if (i>=0 && i<board.length && j>=0 && j<board[i].length){
            cell = board[i][j];
            if (!cell.isRevealed && !cell.isMine) {
                console.log(cell.numberOfMinesAround);
                uncoverCell(i, j);
                debugger;
        }
      }
    }
  }
}