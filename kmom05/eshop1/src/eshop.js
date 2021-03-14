/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    showProducts: showProducts,
    getCategories: getCategories,
    getCustomers: getCustomers,
    createProduct: createProduct,
    getProduct: getProduct,
    getCategory: getCategory,
    getProductsInCat: getProductsInCat,
    updateProduct: updateProduct,
    deactivateProduct: deactivateProduct,
    activateProduct: activateProduct,
    deleteProduct: deleteProduct,
    getLogs: getLogs,
    getProductsCategories: getProductsCategories
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
async function showProducts() {
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
