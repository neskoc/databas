/**
 * Program showing content of the larare.
 *
 * @author Nenad Cuturic
 */
"use strict";

const config = require("./config.json");
const mysql = require("promise-mysql");
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
        json;

    json = await func.getMaxLengths(db);
    console.info(Object.keys(json[0]));
    console.info(Object.values(json[0]));
    console.info("-".repeat(json[0].max_avd));
    str = await func.getTeachers(db);
    console.info(str);

    db.end();
})();
