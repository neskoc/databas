/**
 * Search within table
 *
 * @author Nenad Cuturic
 */
'use strict';

const config = require("./config.json");
const mysql = require("promise-mysql");

// Read from commandline
const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// Promisify rl.question to question
const util = require("util");

rl.question[util.promisify.custom] = (arg) => {
    return new Promise((resolve) => {
        rl.question(arg, resolve);
    });
};
const question = util.promisify(rl.question);
const func = require("./functions.js");

/**
 * Main function.
 *
 * @async
 * @returns void
 */
(async function() {
    const db = await mysql.createConnection(config);
    let str,
        json,
        search;

    search = await question("What to search for? ");
    json = await func.getMaxLengths(db);
    console.info(json[0]);
    str = await func.searchTeachers(db, search);
    console.info(str);

    rl.close();
    db.end();
})();
