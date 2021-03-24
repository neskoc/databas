/**
 * A collection of useful functions.
 *
 * @author Nenad Cuturic
 */
/* jshint node: true */
/* jshint esversion: 8 */
"use strict";

// const { table } = require("node:console");

module.exports = {
    "getAll": getAll,
    "searchStr": searchStr,
    "showReport": showReport
};



/**
 * Fetch a specified number of lines from log.
 *
 * @param {connection} db     Database connection.
 * @param {search} str        Search string.
 * @returns {query result}    Result from the query
 */
async function getAll(db) {
    let res = await searchStr(db, '');
    // console.log(res);
    // console.log(nrOfLines, search);

    return res;
}



/**
 * Get from inventory..
 *
 * @param {connection} db     Database connection.
 * @param {array} searchStr   Filter for search in inventory.
 * @returns {void}
 */

 async function searchStr(db, searchStr) {
    let sql = "CALL get_all(?)";
    searchStr = `%${searchStr}%`;
    let res = await db.query(sql, [searchStr]);

    return res[0];
}


/**
 * get all available shelves.
 *
 * @param {connection} db     Database connection.
 * @returns {query result}    Result from the query
 */

async function showReport(db) {
    let sql = "CALL get_report()";
    let res = await db.query(sql);
    console.table(res[0]);
}
