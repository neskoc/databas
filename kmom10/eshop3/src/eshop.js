/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    "getProducts": getProducts,
    "getCategories": getCategories,
    "getCustomers": getCustomers,
    "getCustomer": getCustomer,
    "createProduct": createProduct,
    "getProduct": getProduct,
    "getCategory": getCategory,
    "getProductsInCat": getProductsInCat,
    "updateProduct": updateProduct,
    "deactivateProduct": deactivateProduct,
    "activateProduct": activateProduct,
    "deleteProduct": deleteProduct,
    "getLogs": getLogs,
    "getProductsCategories": getProductsCategories,
    "getOrder": getOrder,
    "getInvoiceByOrderid": getInvoiceByOrderid,
    "getOrders": getOrders,
    "saveOrder": saveOrder,
    "getProductsFromOrderid": getProductsFromOrderid,
    "getProductsFromInvoiceid": getProductsFromInvoiceid,
    "updateOrder": updateOrder,
    "changeOrderStatus": changeOrderStatus,
    "getPicklist": getPicklist
};

const mysql  = require("promise-mysql");
const config = require("../config/db/eshop.json");
const func = require("./functions.js");
let db;

/**
 * Main function.
 * @async
 * @returns void
 */
(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

/**
 * Show all products.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getProducts() {
    return func.getProducts(db);
}

/**
 * Create a new product.
 *
 * @async
 * @returns {void}
 */
async function createProduct(body) {
    await func.addProduct(db, body);
}

/**
 * Get a product.
 *
 * @async
 * @returns {void}
 */
async function getProduct(id) {
    return await func.getProduct(db, id);
}

/**
 * Update a product.
 *
 * @async
 * @returns {void}
 */
async function updateProduct(body) {
    await func.updateProduct(db, body);
}

/**
 * Deactivate product.
 *
 * @async
 * @returns {void}
 */
async function deactivateProduct(id) {
    await func.deactivateProduct(db, id);
}

/**
 * Activate product.
 *
 * @async
 * @returns {void}
 */
async function activateProduct(id) {
    await func.activateProduct(db, id);
}

/**
 * Permanently delete product.
 *
 * @async
 * @returns {void}
 */
async function deleteProduct(id) {
    await func.deleteProduct(db, id);
}

/**
 * Get all categories.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getCategories() {
    return func.getCategories(db);
}

/**
 * Get specific customer.
 *
 * @async
 * @param {int} Customer id.
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getCustomer(customer_id) {
    return func.getCustomer(db, customer_id);
}

/**
 * Get all customers.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getCustomers() {
    return func.getCustomers(db);
}

/**
 * Get specific category.
 *
 * @async
 * @returns {void}
 */
async function getCategory(id) {
    return await func.getCategory(db, id);
}

/**
 * Get categories for the specific product.
 *
 * @async
 * @returns {void}
 */
async function getProductsCategories(id) {
    return await func.getProductsCategories(db, id);
}

/**
 * Show all products in the category.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getProductsInCat(id) {
    return await func.getProductsInCat(db, id);
}

/**
 * Get all customers.
 *
 * @async
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getLogs(search = "%%") {
    return func.getLogs(db, 20, search);
}

/**
 * Save order.
 *
 * @async
 * @returns {void}
 */
async function saveOrder(req_body) {
    func.saveOrder(db, req_body);
}

/**
 * Get an order.
 *
 * @async
 * @param {int}  Order id.
 * 
 * @returns {void}
 */
async function getOrder(id) {
    return await func.getOrder(db, id);
}

/**
 * Get an invoice.
 *
 * @async
 * @param {int}  Order id.
 * 
 * @returns {void}
 */
async function getInvoiceByOrderid(order_id) {
    return await func.getInvoiceByOrderid(db, order_id);
}

/**
 * Get orders.
 *
 * @async
 * @returns {void}
 */
async function getOrders() {
    return func.getOrders(db);
}

/**
 * Get order rows for order id.
 *
 * @async
 * @param {int}  Order id.
 * 
 * @returns {RowDataPacket} Resultset from the query
 */
async function getProductsFromOrderid(order_id) {
    return func.getProductsFromOrderid(db, order_id);
}

/**
 * Get invoice rows for invoice id..
 *
 * @async
 * @param {int} Invoice id.
 *
 * @returns {RowDataPacket} Resultset from the query
 */
async function getProductsFromInvoiceid(invoice_id) {
    return func.getProductsFromInvoiceid(db, invoice_id);
}

/**
 * Update existing order.
 *
 * @async
 * @param {int}  Order id.
 * 
 * @returns {void}
 */
 async function updateOrder(body, order_id) {
    await func.updateOrder(db, body, order_id);
}

/**
 * Send order (change status).
 *
 * @async
 * @param {int}  Order id.
 * 
 * @returns {void}
 */
async function changeOrderStatus(order_id, status) {
    func.changeOrderStatus(db, order_id, status);
}


/**
 * Get invoice rows for invoice id..
 *
 * @async
 * @param {int} Invoice id.
 *
 * @returns {RowDataPacket} Resultset from the query
 */
 async function getPicklist(invoice_id) {
    return func.getPicklist(db, invoice_id);
}
