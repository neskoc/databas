/**
 * Program showing content of the larare v.2
 * This script is using more general view function
 *
 * @author Nenad Cuturic
 */
"use strict";

const config = require("./config.json");
const mysql = require("promise-mysql");
const func = require("./functions.js");
const columns = {
    "Akronym":   "start",
    "Förnamn":   "start",
    "Efternamn": "start",
    "Avd":       "",
    "Lön":       "end",
    "Komp":      "end",
    "Född":      "start",
};

/**
 * Main function.
 *
 * @async
 * @returns void
 */
(async function() {
    const db = await mysql.createConnection(config);
    let str,
        json;

    json = await func.getMaxLengths(db);
    // console.info(Object.keys(json[0]));
    console.info(Object.values(json[0]));
    str = await func.getTeachers2(db, columns, Object.values(json[0]));
    console.info(str);

    db.end();
})();
