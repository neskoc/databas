/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    "showReport": showReport,
    "searchStr": searchStr,
    "getAll": getAll
};

const mysql  = require("promise-mysql");
const config = require("../config/db/exam.json");
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
 * Show report.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showReport() {
    return func.showReport(db);
}


/**
 * Show all.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getAll() {
    return func.getAll(db);
}


/**
 * Get all customers.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function searchStr(search = "%%") {
    return func.searchStr(db, search);
}

