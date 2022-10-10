
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

//En el apartado de mine:false crear despues una function que los ponga random contando cada numero de random hasta que te quedes sin poner ninguna mina. !!!!!!
function minefieldCreation(){
    for (let i = 0; i < obj.height; i++){
        mineField.push([])
        console.log("----------"+i)
            for (let j = 0; j < obj.width; j++){
                console.log(j);
                mineField[i].push({
                    mine:false,
                    hidden:true,
                    num:null
                })
            }
    }
    if (mineField[0,1].mine == false){
        console.log("mineField[0,1]")

    }
}

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
