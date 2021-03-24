/**
 * Route for Exam.
 */
"use strict";

const express = require("express");
const router  = express.Router();
const exam = require("../../src/exam.js");

router.get(["/", "/index"], (req, res) => {
    let data = {
        title: "Välkommen | Exam",
        path: req.path
    };
    req.session.name = 'Exam';

    res.render("exam/index", data);
});


router.get("/visa", async (req, res) => {
    let data = {
        title: "Visa | Exam",
        res: await exam.getAll(),
        path: req.path
    };

    res.render("exam/visa", data);
});

router.get("/search", async (req, res) => {
    let data = {
        title: "Sök | Exam",
        res: await exam.getAll(),
        path: req.path
    };

    res.render("exam/search", data);
});

router.post("/search", async (req, res) => {
    let data = {
        title: "Sök | Exam",
        res: await exam.searchStr('%' + req.body.search + '%'),
        path: req.path
    };

    res.render("exam/search", data);
});

module.exports = router;
