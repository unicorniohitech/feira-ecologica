
//index.js
require("dotenv").config();

const db = require("./db");

function start() {
    const db = require("./db");
    const { queries } = require('./queries')
    console.log('Começou!');

    queries.map((item) => {
        const clientes = db.executeCustomQuery(item);
    })
    // console.log(clientes);
}

start();
