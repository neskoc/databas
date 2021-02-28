/**
 * Kmom04:
 * Node.js terminalprogram mot MySQL med kommandoloop.
 * By necu20 for dbwebb databas.
 * 2021-02-14
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config/db/bank.json");
const func = require("./src/functions.js");

// Read from commandline
const readline = require('readline');
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
        case "quit":
        case "exit":
            process.exit();
            break;
        case "help":
        case "menu":
            visaMeny();
            break;
        case "balance":
            await visaBalans(db);
            break;
        default:
            await kommand(db, line);
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
        `  exit, quit, ctrl-d    - exit.\n` +
        `  help, menu           - show this men.\n` +
        `  balance                 - show account's balances.\n` +
        `  move [<fromAccount> <toAccount>] <amount > - move bitcoins.\n`
    );
}


/**
 * Show account balances.
 *
 * @returns {void}
 */
async function visaBalans(db) {
    let res = await func.findAllInTable(db, "account");

    console.table(res);
}


/**
 * Init the game and guess on (another) number.
 *
 * @returns {void}
 */
async function kommand(db, line) {
    let split = line.split(" ");

    if (split[0] === "move") {
        switch (split.length) {
            case 2:
                await func.moveBitcoins(db, split[1]);
                break;
            case 4:
                await func.moveBitcoins(db, split[3], split[1], split[2]);
                break;
            default:
                console.error("Command syntax: move [<fromAccount> <toAccount>] <amount>");
                break;
        }
    } else {
        console.error("The command must be 'move'!");
    }

    rl.prompt();
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
