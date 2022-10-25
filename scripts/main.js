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
gameData();
smile();

function addEventClick() {
    var ejes = [];
    let cells = document.getElementsByTagName("td");
    for (const elements of cells) {
        elements.addEventListener('mousedown', (Event) => {
            if(Event.button==0){
                console.log(elements.getAttribute("id"));
                ejes = elements.getAttribute("id").split('-');
                console.log("ejes:    "+ejes);
                if(board[ejes[0]][ejes[1]].isMine){
                    updateCell(ejes[0],ejes[1],"isMineExploded",true);
                    revealMine(ejes[0],ejes[1]);
                    revealAllMines();
                    console.log("buum");
                    obj.state="lost";
                    smile();
                }
            }else if(Event.button==2){
                ejes = elements.getAttribute("id").split('-');
                if(board[ejes[0][ejes[0]]].isFlagged){
                   //questionmarked
                   updateCell(ejes[0][ejes[1]],"isQuestionMarked",true); 
                }
                flagCell(ejes[0],ejes[1]);
                console.log(ejes);
            }
           
        });
        elements.addEventListener('contextmenu', (Event) => {
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
        console.log("hay mockData");
        console.log(board);
        obj.numMines = countMines(mockData);
        board = createBoardFromMockData(mockData);
        generateTable(board.length,board.length);
        addEventClick();
        randomMines();
    }else{
        minefieldCreation();
        generateTable(obj.height,obj.width);
        randomMines();
        console.log(board);
        addEventClick();
    }
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
    console.log(board);
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
                numberOfMinesAround: 0,
                isMine: false
                })
            }
    }
    
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

function revealMine(num1,num2){
    var cell = document.getElementById(num1+"-"+num2);
    updateCell(num1,num2,"isRevealed",true);
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
function flagCell(num1, num2){
    var cell = document.getElementById(num1+"-"+num2);
    updateCell(num1,num2,"isFlagged",true);
    cell.classList.add("flagCell");
    cell.classList.remove("cell");
}

function updateCell(num1,num2,property,value){
    board[num1][num2][property] = value;
    if(board[num1][num2].isRevealed){
        board[num1][num2].isFlagged = false;
        board[num1][num2].isQuestionMarked = false;
    }else if(board[num1][num2].isFlagged){
        board[num1][num2].isQuestionMarked = false;
    }else if(board[num1][num2].isQuestionMarked){
        board[num1][num2].isFlagged = false;
    }
    console.log("celda actualizada");
}