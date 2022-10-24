var board = [];

function gameData(){
    var game = {}
    game.state = "";
    game.smile = "normal";
    game.height = "8";
    game.width = "8";
    game.numMines = "10";
    game.timer = "0";
    return game;
}
const obj = gameData();
gameData();
smile();
function addEventClick() {
    var ejes = [];
    let cells = document.getElementsByTagName("td");
    for (const elements of cells) {
        elements.addEventListener('click', () => {
            console.log(elements.getAttribute("id"));
            ejes = elements.getAttribute("id").split('-');
            console.log("ejes:    "+ejes);
            if(board[ejes[0]][ejes[1]].isMine){
                revealMine(ejes[0],ejes[1]);
                console.log("buum");
                obj.state="lost";
                smile();
            }
        });
        elements.addEventListener('click', () => {
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
    }else{
        minefieldCreation();
        generateTable(obj.height,obj.width);
        addEventClick();
    }
    flagCounter();
})

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
  
const mineField = [];
//En el apartado de mine:false crear despues una function que los ponga random contando cada numero de random hasta que te quedes sin poner ninguna mina. !!!!!!
function minefieldCreation(){
    for (let i = 0; i < obj.height; i++){
        mineField.push([])
            for (let j = 0; j < obj.width; j++){
                mineField[i].push({
                    mine:false,
                    hidden:true,
                    num:null
                })
            }
    }
    
}

function generateTable(height,width){
    addEventClick();
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
    cell.classList.add("cellMine");
    cell.classList.remove("cell");
}