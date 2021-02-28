/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    showBalance: showBalance,
    moveToAdam: moveToAdam
};

const mysql  = require("promise-mysql");
const config = require("../config/db/bank.json");
const func = require("./functions.js");
let db;

/**
 * Main function.
 * @async
 * @returns void
 */
(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

/**
 * Show all entries in the account table.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showBalance() {
    return func.findAllInTable(db, "account");
}

/**
 * Show all entries in the account table.
 *
 * @async
 * @returns {boolean}.
 */
async function moveToAdam() {
    const amount = 1.5;

    await func.moveBitcoins(db, amount);
}
