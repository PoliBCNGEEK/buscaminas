const { findLast } = require("lodash");

smile();
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

/*
minefield[]

bucle findLast i
    mineField.push([])

    bucle columnas j
        mineField[i].push 

minefield.push({
    state = "";
    smile = "normal";
    height = "8";
    width = "8";
    numMines = "10";
})

mineField[0,2].state

*/

function  smile(){
    var src = document.getElementById("smile");
    var img = document.createElement("img");
    //poner despues un if para cambiar el smile
    img.src = "./img/smile-normal.png";
    src.appendChild(img);
}
