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

// Promisify rl.question to question
import { promisify } from "util";
rl.question[promisify.custom] = (arg) => {
    return new Promise((resolve) => {
        rl.question(arg, resolve);
    });
};
const question = promisify(rl.question);

// Import the game module
// const Game = require("./game.js");
import Game from "./game.js";
const game = new Game();


/**
 * Main function.
 *
 * @async
 * @returns void
 */
(async function() {
    let thinking;
    let guess;
    let match;
    let message;

    game.init();
    thinking = game.cheat();

    guess = await question("Guess my number: ");
    guess = Number.parseInt(guess);
    match = game.check(guess);
    message = `I'm thinking of number ${thinking}.\n`
        + `Youre guess is ${guess}.\n`
        + `You guessed right? `
        + (match);
    console.info(message);

    rl.close();
})();
