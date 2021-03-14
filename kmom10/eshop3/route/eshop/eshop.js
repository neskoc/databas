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
    req.session.name = 'Eshop3';

    res.render("eshop/index", data);
});

router.get("/product", async (req, res) => {
    let data = {
        title: "Produkter | Eshop",
        res: await eshop.getProducts(),
        path: req.path
    };

    res.render("eshop/product", data);
});

router.get("/update_product", async (req, res) => {
    let data = {
        title: "Uppdatera produkt | Eshop",
        res: await eshop.getProducts(),
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

router.get("/order", async (req, res) => {
    let data = {
        title: "Beställningar | Eshop",
        res: await eshop.getOrders(),
        path: req.path
    };

    res.render("eshop/order.ejs", data);
});

router.get("/picklist/:order_id", async (req, res) => {
    let data = {
        title: "Plocklista | Eshop",
        path: req.path
    };

    let picklist = await eshop.getPicklist(req.params.order_id);
    data.res = picklist[0];
    data.kund_id = picklist[1];
    data.order_id = req.params.order_id;

    res.render("eshop/picklist.ejs", data);
});


router.get("/create_order/:id", async (req, res) => {
    let data = {
        title: "Skapa beställning | Eshop",
        res: await eshop.getProducts(),
        kund: await eshop.getCustomer(req.params.id),
        path: req.path
    };
    req.session.kund_id = req.params.id;

    res.render("eshop/order/create_order", data);
});

router.post("/create_order/:kund_id", async (req, res) => {
    await eshop.saveOrder(req.body);

    res.redirect("/eshop/order");
});

router.get("/update_order", async (req, res) => {
    let data = {
        title: "Redigera beställning | Eshop",
        kund: await eshop.getCustomer(req.query.customer_id),
        res: await eshop.getProductsFromOrderid(req.query.order_id),
        order_id: req.query.order_id,
        path: req.path
    };
    req.session.kund_id = req.query.customer_id;
    req.session.order_id = req.query.order_id;

    res.render("eshop/order/update_order", data);
});

router.post("/update_order", async (req, res) => {
    await eshop.updateOrder(req.body, req.session.order_id);

    res.redirect("order");
});

router.get("/change_order_status", async (req, res) => {
    let order_id = req.query.order_id;
    let status = req.query.status;

    status = status != "bestalld" ? status : "beställd";
    await eshop.changeOrderStatus(order_id, status);

    res.redirect("order");
});

router.get("/show_order", async (req, res) => {
    let data = {
        title: "Komplett order | Eshop",
        kund: await eshop.getCustomer(req.query.customer_id),
        res: await eshop.getProductsFromOrderid(req.query.order_id),
        order_id: req.query.order_id,
        path: req.path
    };
    let order = await eshop.getOrder(req.query.order_id);
    const date = new Date(order.skapad);

    date.setHours(date.getHours() + 1);
    data.order_skapad = date.toISOString().slice(0, 10) + ' ' + date.toISOString().slice(11, 19);
    data.order_status = order.status;

    res.render("eshop/order/show_order", data);
});

router.get("/invoice", async (req, res) => {
    let data = {
        title: "Faktura | Eshop",
        kund: await eshop.getCustomer(req.query.customer_id),
        order_id: req.query.order_id,
        path: req.path
    };
    let order = await eshop.getOrder(req.query.order_id);
    let date = new Date(order.skapad);

    date.setHours(date.getHours() + 1);
    data.order_skapad = date.toISOString().slice(0, 10) + ' ' + date.toISOString().slice(11, 19);
    data.order_status = order.status;

    const invoice = await eshop.getInvoiceByOrderid(req.query.order_id);

    data.invoice_id = invoice.faktura_id;
    data.res = await eshop.getProductsFromInvoiceid(invoice.faktura_id);

    date = new Date(invoice.skapad);
    date.setHours(date.getHours() + 1);
    data.invoice_skapad = date.toISOString().slice(0, 10) + ' ' + date.toISOString().slice(11, 19);
    data.invoice_status = invoice.status;
    if (invoice.betalld !== null) {
        date = new Date(invoice.betalld);
        date.setHours(date.getHours() + 1);
        data.invoice_betalld = date.toISOString().slice(0, 10);
    } else {
        data.invoice_betalld = null;
    }
    console.log(data.invoice_betalld);

    res.render("eshop/invoice.ejs", data);
});

router.get("/session", function(req, res){ 
   
    var data = {
        title: "Session | Eshop",
        path: req.path,
        name: req.session.name,
        kund_id: req.session.kund_id,
        order_id: req.session.bestallning_id
    }
    res.render("eshop/session", data);
   
    /*  To destroy session you can use 
        this function  
     req.session.destroy(function(error){ 
        console.log("Session Destroyed") 
    }) 
    */
}) 

module.exports = router;
