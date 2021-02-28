/**
 * Guess my number, a sample CLI client.
 */
"use strict";

// Read from commandline
import { createInterface } from "readline";
const rl = createInterface({
    input: process.stdin,
    output: process.stdout
});

// // Promisify rl.question to question
// const util = require("util");
//
// rl.question[util.promisify.custom] = (arg) => {
//     return new Promise((resolve) => {
//         rl.question(arg, resolve);
//     });
// };
// const question = util.promisify(rl.question);

// Import the game module
import Game from "./game.js";
const game = new Game();



/**
 * Main function.
 *
 * @returns void
 */
(function() {
    rl.on("close", exitProgram);
    rl.on("line", handleInput);

    game.init();
    console.log(
        "Lets run a game of 'Guess my number'!\n"
        + "I am guessing of a number between 1 and 100.\n"
        + "Can you find out what number I'm guessing?\n"
    );

    rl.setPrompt("Guess my number: ");
    rl.prompt();
})();



/**
 * Handle input as a command and send it to a function that deals with it.
 *
 * @param {string} line The input from the user.
 *
 * @returns {void}
 */
function handleInput(line) {
    let guess;

    line = line.trim();
    switch (line) {
        case "quit":
        case "exit":
            exitProgram();
            break;
        default:
            guess = Number.parseInt(line);
            makeGuess(guess);
    }

    rl.prompt();
}



/**
 * Guess the number and check if its correct.
 *
 * @param {integer} guess The number being guessed.
 *
 * @returns {boolean} true if correct guess, otherwise false.
 */
function makeGuess(guess) {
    let match;
    let message;
    let thinking = game.cheat();

    match = game.check(guess);
    message = `I'm thinking of number (cheating... ${thinking}).\n`
        + `Youre guess is ${guess}.\n`
        + `You guessed right? `
        + match;
    console.info(message);

    return match;
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
