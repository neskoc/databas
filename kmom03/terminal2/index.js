/**
 * Kmom03:
 * Node.js terminalprogram mot MySQL med kommandoloop.
 * By necu20 for course databas.
 * 2021-02-07
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");
const func = require("./functions.js");

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
        "Det är ett terminalprogram för attt jobba mot databasen skolan!\n"
        + "Skriv 'menu' för hela listan.\n"
    );

    rl.setPrompt("Kommandot?: ");
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
        case "larare":
            await visaLarare(db);
            break;
        case "kompetens":
            await visaKompetensrapport(db);
            break;
        case "lon":
            await visaLonrapport(db);
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
        ` Du kan välja bland följande kommandon.\n`
        + `  exit, quit, ctrl-d     - avsluta programmet.\n`
        + `  help, menu             - visa denna meny.\n`
        + `  larare                 - vissa all info om lärare.\n`
        + `  kompetens              - visa rapporten om kompetenserna.\n`
        + `  lon                    - visa rapporten om lönerna.\n`
        + `  sok <söksträng>        - sök bland all information hos lärare och vissa matchningen.\n`
        + `  nylon <akronym> <lon>  - uppdatera lärarens lön.\n`
    );
}



/**
 * Init the game and guess on (another) number.
 *
 * @returns {void}
 */
async function visaLarare(db) {
    console.table(await func.getTeachers(db));
}



/**
 * Check the number current being used as target.
 *
 * @returns {void}
 */
async function visaKompetensrapport(db) {
    let res;

    res = await func.getCompetencies(db);
    console.table(res);
}



/**
 * Guess the number and check if its correct.
 *
 * @param {number} guess The number being guessed.
 *
 * @returns {void}
 */
async function visaLonrapport(db) {
    let res;

    res = await func.getSalaries(db);
    console.table(res);
}



/**
 * Init the game and guess on (another) number.
 *
 * @returns {void}
 */
async function kommand(db, line) {
    let split = line.split(" "),
        res;

    switch (split[0]) {
        case "sok":
            if (split[1]) {
                res = await func.searchTeachers(db, split[1]);
                console.table(res);
            } else {
                console.error("Du behöver ange söksträng!");
            }
            break;
        case "nylon":
            if (split.length == 3) {
                console.log(split[2]);
                let lon = parseFloat(split[2]);

                if (!isNaN(lon)) {
                    res = await func.updateTeachersSalary(db, split[1], lon);
                    if (res.affectedRows == 1) {
                        console.info("Läraren har fått en ny lön!");
                    } else {
                        console.error("Något har gått snett, kontrollera akronym!");
                    }
                } else {
                    console.error("Lön (" + split[2] + ") måste anges som ett heltal!");
                }
            } else {
                console.error("Du behöver ange akronym och en ny lön!");
            }
            break;
        default:
            console.error("Kommandåt måste vara antingen nylon eller sok");
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
