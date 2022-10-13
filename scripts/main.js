
function gameData(){
    var game = {}
    game.state = "";
    game.smile = "normal";
    game.height = "8";
    game.width = "8";
    game.numMines = "10";
    return game;
}
const obj = gameData();

gameData();
smile();
const mineField = [];
minefieldCreation();
generateTable();
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

function generateTable(){
    var table = document.getElementById("table");
    for (let i = 0; i < obj.height; i++){
        var row = document.createElement("tr");
        row.setAttribute("id","row:"+i);
        for (let j = 0; j < obj.width; j++){
            var cell = document.createElement("td");
            var id = "cell:"+i+j;
            var classCell= "cell";
            cell.classList.add(classCell);
            cell.setAttribute("id",id);
            row.appendChild(cell);
        }
        table.appendChild(row);
    }
}


function  smile(){
    var src = document.getElementById("smile");
    var img = document.createElement("img");
    //poner despues un if para cambiar el smile
    img.src = "./img/smile-normal.png";
    src.appendChild(img);
}
