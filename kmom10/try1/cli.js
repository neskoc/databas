/**
 * Exam:
 * Node.js terminalprogram mot MySQL med kommandoloop.
 * By necu20 for dbwebb exam.
 * 2021-03-24
 */
/* jshint node: true */
/* jshint esversion: 8 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config/db/exam.json");
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
        "This is a cli program for working with the exam database!\n" +
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
        case "v":
        case "visa":
            await showAll(db);
            break;
        case "r":
        case "repport":
            await showReport(db);
            break;
        case "q":
        case "quit":
        case "exit":
            process.exit();
            break;
        case "help":
        case "m":
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
        `  v[isa] ............................ - show result.\n` +
        `  s[earch] <str> .................... - search using <str>.\n` +
        `  r[apport] ......................... - rapport.\n` +
        `  m[enu], help ...................... - show this menu.\n` +
        `  q[uit], exit, ctrl-d .............. - exit.\n`
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
        case "s":
        case "search":
            if (split.length === 2) {
                await searchStr(db, split[1]);
            } else {
                console.error("You need to give me precisely one argument: <str>!");
            }
            break;
        case "se":
            await searchStr(db, "test");
            break;
        default:
            console.error("Unknown command! Try 'menu' for all available commands");
            break;
    }

    rl.prompt();
}


/**
 * Search for str.
 *
 * @param {connection} db     Database connection.
 * @param {str} searchStr     Filter for search in inventory.
 * @returns {void}
 */
async function searchStr(db, search) {
    search = "%" + search + "%";
    let res = await func.searchStr(db, search);

    console.table(res);
}


/**
 * Show all.
 *
 * @param {connection} db     Database connection.
 * @returns {void}
 */
async function showAll(db) {
    let res = await func.getAll(db);
    console.table(res);
}


/**
 * Show report.
 *
 * @param {connection} db     Database connection.
 * @returns {void}
 */
async function showReport(db) {
    await func.showReport(db);
}


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
