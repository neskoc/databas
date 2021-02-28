/**
 * Route for bank.
 */
"use strict";

const express = require("express");
const router  = express.Router();
const bank    = require("../src/bank.js");

router.get(["/", "/index"], (req, res) => {
    let data = {
        title: "Welcome | The Bank",
        path: req.path
    };

    res.render("bank/index", data);
});

router.get("/balance", async (req, res) => {
    let data = {
        title: "Account balance | The Bank",
        path: req.path
    };

    data.res = await bank.showBalance();

    res.render("bank/balance", data);
});

router.get("/move-to-adam", async (req, res) => {
    let data = {
        title: "Move 1.5 bcoins to Adam | The Bank",
        msg: "Adam says thanks!",
        path: req.path
    };

    await bank.moveToAdam();

    res.render("bank/move-to-adam", data);
});

module.exports = router;
