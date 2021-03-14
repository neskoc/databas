/**
 * Kmom04:
 * Node.js terminalprogram mot MySQL med kommandoloop.
 * By necu20 for dbwebb databas.
 * 2021-02-14
 */
/* jshint node: true */
/* jshint esversion: 8 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config/db/eshop.json");
const func = require("./src/functions.js");

// Read from commandline
const readline = require('readline');
const { version } = require("process");
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

/**
 * Main function.
 *
 * @returns void
 */
(async function() {
    rl.on("close", exitProgram);
    rl.on("line", handleInput);

    console.log(
        "This is a cli program for working with the dbwebb database!\n" +
        "Type 'menu' for all available commands.\n"
    );

    rl.setPrompt("Command?: ");
    rl.prompt();
})();



/**
 * Handle input as a command and send it to a function that deals with it.
 *
 * @param {string} line The input from the user.
 *
 * @returns {void}
 */
async function handleInput(line) {
    const db = await mysql.createConnection(config);

    line = line.trim();
    switch (line) {
        case "about":
            await func.aboutMe();
            break;
        case "shelf":
            await showShelves(db);
            break;
        case "inventory":
            await showInventory(db);
            break;
        case "quit":
        case "exit":
            process.exit();
            break;
        case "help":
        case "menu":
            visaMeny();
            break;
        default:
            await commands(db, line);
            break;
    }

    rl.prompt();
}


/**
 * Show the menu on that can be done.
 *
 * @returns {void}
 */
function visaMeny() {
    console.info(
        ` You can choose between these commands:.\n` +
        `  log <number> ...................... - show last <number> of rows in lag.\n` +
        `  shelf ............................. - show all available shelves.\n` +
        `  inventory [<str>] ................. - show all products in storage, optional <str> filters out produktid/produktnamn/lagerhylla.\n` +
        `  invadd <productid> <shelf> <number> - add <number> of product to the inventory on <shelf>.\n` +
        `  invdel <productid> <shelf> <number> - remove <number> of product from the inventory off the <shelf>.\n` +
        `  logsearch <str> ................... - show log content filtering out with <str>.\n` +
        `  order [<search>] .................. - show all orders or filter out with the optional <search>.\n` +
        `  picklist <orderid> ................ - generate picklist for the chosen order with <orderid>.\n` +
        `  ship <orderid> .................... - change status for the order with <orderid> to "skickad".\n` +
        `  payed <invoiceid> <date> .......... - change invoice <invoiceid> status to "payed" at <date>.\n` +
        `  about ............................. - show all available shelves.\n` +
        `  exit, quit, ctrl-d ................ - exit.\n` +
        `  help, menu ........................ - show this menu.\n`
    );
}


/**
 * Init the game and guess on (another) number.
 *
 * @returns {void}
 */
async function commands(db, line) {
    let split = line.split(" ");

    switch (split[0]) {
        case "log":
            if (split.length === 2) {
                await showLogs(db, split[1]);
            } else {
                console.error("You need to give me just one argument: <number>!");
            }
            break;
        case "logsearch":
            if (split.length === 2) {
                await showLogs(db, null, split[1]);
            } else {
                console.error("You need to give me just one argument: <search>!");
            }
            break;
        case "inventory":
            if (split.length === 2) {
                await showInventory(db, split[1]);
            } else {
                console.error("You need to give me just one argument: <str>!");
            }
            break;
        case "invadd":
            if (split.length === 4) {
                await func.addToInventory(db, split.slice(1,4));
            } else {
                console.error("You need to give me three arguments: <productid> <shelf> <number>!");
            }
            break;
        case "invdel":
            if (split.length === 4) {
                await func.removeFromInventory(db, split.slice(1,4));
            } else {
                console.error("You need to give me three arguments: <productid> <shelf> <number>!");
            }
            break;
        default:
            console.error("Unknown command! Try 'menu' for all available commands");
            break;
    }

    rl.prompt();
}


/**
 * Show a specified number of lines from logs.
 *
 * @param {connection} db     Database connection.
 * @param {int} nrOfLines     Number of lines to get from log.
 * @returns {void}
 */
async function showLogs(db, nrOfLines, search = null) {
    if (search !== null) {
        search = `%${search}%`;
    }
    let res = await func.getLogs(db, nrOfLines, search);

    console.table(res);
}


/**
 * Show all available shelves.
 *
 * @param {connection} db     Database connection.
 * @returns {void}
 */
async function showShelves(db) {
    let res = await func.getShelves(db);

    console.table(res);
}


/**
 * Show inventory.
 *
 * @param {connection} db     Database connection.
 * @param {str} searchStr     Filter for search in inventory.
 * @returns {void}
 */
async function showInventory(db, searchStr = "") {
    let res = await func.getInventory(db, searchStr);

    console.table(res);
}


/**
 * add number of product(s) to the inventory on the specific shelf.
 *
 * @param {connection} db     Database connection.
 * @param {array} line        <productid> <shelf> <number>.
 * @returns {void}
 */
/*
async function addToInventory(db, line) {
    let res = await func.getLogs(db, line);

    console.table(res);
}
*/

/**
 * Close down program and exit with a status code.
 *
 * @param {number} code Exit with this value, defaults to 0.
 *
 * @returns {void}
 */
function exitProgram(code) {
    code = code || 0;

    console.info("Exiting with status code " + code);
    process.exit(code);
}
