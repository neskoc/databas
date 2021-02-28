/**
 * A test program to show off async and await.
 *
 * @author Mitt Namn
 */
"use strict";

const fs = require("fs");
const path = "file.txt";
let data;

console.info("1) Program is starting up!");

data = getFileContentSync(path);
console.info(data);

console.info("3) End of the program!");

/**
 * Return the content of the file, synced version which works.
 *
 * @param {string}   The path to the file to read.
 *
 * @returns {string} The content of the file.
 */
function getFileContentSync(filename) {
    let data;

    data = fs.readFileSync(filename, "utf-8");
    return data;
}
