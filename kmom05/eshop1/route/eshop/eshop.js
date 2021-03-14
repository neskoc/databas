/**
 * Route for eshop.
 */
"use strict";

const express = require("express");
const router  = express.Router();
const eshop = require("../../src/eshop.js");

router.get(["/", "/index"], (req, res) => {
    let data = {
        title: "Välkommen | Eshop",
        path: req.path
    };

    res.render("eshop/index", data);
});

router.get("/product", async (req, res) => {
    let data = {
        title: "Produkter | Eshop",
        res: await eshop.showProducts(),
        path: req.path
    };

    res.render("eshop/product", data);
});

router.get("/update_product", async (req, res) => {
    let data = {
        title: "Uppdatera produkt | Eshop",
        res: await eshop.showProducts(),
        path: req.path
    };

    res.render("eshop/product/update_product", data);
});

router.get("/create_product", async (req, res) => {
    let data = {
        title: "Skapa ny produkt | Eshop",
        path: req.path
    };

    res.render("eshop/product/create_product", data);
});

router.post("/create_product", async (req, res) => {
    // console.info(req.body);
    await eshop.createProduct(req.body);
    res.redirect("product");
});

router.get("/update_product/:id", async (req, res) => {
    let data = {
        title: "Uppdatera produkt | Eshop",
        path: req.path
    };
    let query_res = await eshop.getProduct(req.params.id);
    let query_all_cat = await eshop.getCategories(req.params.id);
    let query_cat = await eshop.getProductsCategories(req.params.id);
    let member_cat = [];

    for (const row of query_cat) {
        member_cat.push(row.kategorinamn);
    }
    data.res = query_res[0];
    data.query_all_cat = query_all_cat;
    data.member_cat = member_cat;
    res.render("eshop/product/update_product", data);
});

router.post("/update_product", async (req, res) => {
    // console.info(req.body);
    await eshop.updateProduct(req.body);
    res.redirect("/eshop/product");
});

router.get("/deactivate_product/:id", async (req, res) => {
    await eshop.deactivateProduct(req.params.id);
    res.redirect("/eshop/product");
});

router.get("/activate_product/:id", async (req, res) => {
    await eshop.activateProduct(req.params.id);
    res.redirect("/eshop/product");
});

router.get("/delete_product/:id", async (req, res) => {
    await eshop.deleteProduct(req.params.id);
    res.redirect("/eshop/product");
});

router.get("/category", async (req, res) => {
    let data = {
        title: "Kategorier | Eshop",
        res: await eshop.getCategories(),
        path: req.path
    };

    res.render("eshop/category", data);
});

router.get("/customer", async (req, res) => {
    let data = {
        title: "Kunder | Eshop",
        res: await eshop.getCustomers(),
        path: req.path
    };

    res.render("eshop/customer", data);
});

router.get("/log", async (req, res) => {
    let data = {
        title: "Logg | Eshop",
        res: await eshop.getLogs(),
        path: req.path
    };

    res.render("eshop/log", data);
});

router.post("/log", async (req, res) => {
    let data = {
        title: "Logg | Eshop",
        res: await eshop.getLogs('%' + req.body.search + '%'),
        path: req.path
    };

    res.render("eshop/log", data);
});

router.get("/cat2prod/:id", async (req, res) => {
    let data = {
        title: "Produkter i kategori | Eshop",        
        path: req.path
    };
    let cat_res = await eshop.getCategory(req.params.id);
    let prods_res = await eshop.getProductsInCat(req.params.id);

    console.log("kat namn:", cat_res[0].kategorinamn);
    console.log("prods:", prods_res);

    for (const row of prods_res) {
        console.log("row:", row);
    }
    data.cat = cat_res[0];
    data.prods = prods_res;

    res.render("eshop/cat2prod", data);
});


router.get("/about", async (req, res) => {
    let data = {
        title: "Om | Eshop",
        path: req.path
    };

    res.render("eshop/about", data);
});


module.exports = router;
