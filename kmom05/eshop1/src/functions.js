/**
 * A collection of useful functions.
 *
 * @author Nenad Cuturic
 */
/* jshint node: true */
/* jshint esversion: 8 */
"use strict";

module.exports = {
    "aboutMe": aboutMe,
    "getLogs": getLogs,
    "getShelves": getShelves,
    "getInventory": getInventory,
    "addToInventory": addToInventory,
    "removeFromInventory": removeFromInventory,
    "getProducts": getProducts,
    "getCategory": getCategory,
    "getCategories": getCategories,
    "getProductsInCat": getProductsInCat,
    "addProduct": addProduct,
    "getProduct": getProduct,
    "updateProduct": updateProduct,
    "deactivateProduct": deactivateProduct,
    "activateProduct": activateProduct,
    "deleteProduct": deleteProduct,
    "getCustomers": getCustomers,
    "getProductsCategories": getProductsCategories
};


/**
 * Show info about the author.
 * @async
 * @param  {void}
 * @returns  {void}
 * 
 */
async function aboutMe() {
    const author = "Nenad Cuturic, ";
    const course_details = "DV1606/DV1605 V21 lp3 Databasteknologier för webben";

    console.info(`\nFörfattare: ${author}\nKurs: ${course_details}\n`);
}


/**
 * Fetch a specified number of lines from log.
 *
 * @param {connection} db     Database connection.
 * @param {int} nrOfLines     Number of lines to get from log.
 * @returns {query result}    Result from the query
 */
async function getLogs(db, nrOfLines = -1, search = null) {
    let sql = "CALL get_logs(?, ?)";
    let res = await db.query(sql, [search, nrOfLines]);
    console.log(res);
    console.log(nrOfLines, search);

    return res[0];
}


/**
 * get all available shelves.
 *
 * @param {connection} db     Database connection.
 * @returns {query result}    Result from the query
 */

async function getShelves(db) {
    let sql = "CALL get_shelves()";
    let res = await db.query(sql);

    return res[0];
}


/**
 * Get from inventory..
 *
 * @param {connection} db     Database connection.
 * @param {array} searchStr   Filter for search in inventory.
 * @returns {void}
 */

async function getInventory(db, searchStr) {
    let sql = "CALL get_inventory(?)";
    searchStr = `%${searchStr}%`;
    let res = await db.query(sql, [searchStr]);

    return res[0];
}


/**
 * add number of product(s) to the inventory on the specific shelf.
 *
 * @param {connection} db     Database connection.
 * @param {array} list        <productid> <shelf> <number>.
 * @returns {void}
 */
async function addToInventory(db, list) {
    let sql = "CALL increase_inventory(?,?,?)";

    try {
        await db.query(sql, [list[0], list[1], list[2]]);
        console.log("Inventory updated!");
    } catch (err) {
        console.error("Could't update inventory!\n", err);
    }
}


/**
 * remove number of product(s) from the inventory specifying the shelf.
 *
 * @param {connection} db     Database connection.
 * @param {array} list        <productid> <shelf> <number>.
 * @returns {void}
 */
async function removeFromInventory(db, list) {
    let sql = "CALL decrease_inventory(?,?,?,@call_status); SELECT @call_status AS status;";

    try {
        let res = await db.query(sql, [list[0], list[1], list[2]]);
        let res_as_json = JSON.parse(JSON.stringify(res))

        // console.info(res_as_json[1][0]);
        // console.info(res_as_json[1][0].status);
        if (res_as_json[1][0].status === 0) {
            console.log("Inventory updated!\n");
        } else {
            console.warn("Number items on the shelf is less then the given numbers!");
            console.info("Please try again.");
        }
    } catch (err) {
        console.error("Couldn't update inventory!\n", err);
    }
}


/**
 * Get all products.
 *
 * @async
 * @param {void}.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getProducts(db) {
    let sql = "CALL get_products()";
    let res = await db.query(sql);

    return res[0];
}


/**
 * Get all categories.
 *
 * @async
 * @param {void}.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getCategories(db) {
    let sql = "CALL get_categories()";
    let res = await db.query(sql);

    return res[0];
}


/**
 * Get categories for the specific product.
 *
 * @async
 * @param {int} Product id.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getProductsCategories(db, product_id) {
    let sql = "CALL get_products_categories(?)";
    let res = await db.query(sql, [product_id]);

    return res[0];
}


/**
 * Get product with specific id.
 *
 * @async
 * @param {int} Product id.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getProduct(db, product_id) {
    let sql = "CALL get_product(?)";
    let res = await db.query(sql, [product_id]);

    return res[0];
}


/**
 * Create a new product.
 *
 * @async
 * @param {req.body} Input parameters.
 *
 * @returns {void}.
 */
async function addProduct(db, body) {
    let sql = "CALL add_product(?,?,?,?)";

    await db.query(sql, [body.namn, body.pris, body.beskrivning, body.bildlank]);
}


/**
 * Update product.
 *
 * @async
 * @param {req.body} Input parameters.
 *
 * @returns {void}.
 */
async function updateProduct(db, body) {
    let sql = "CALL update_product(?,?,?,?,?)";
    
    await db.query(sql, [body.id, body.namn, body.pris, body.beskrivning, body.bildlank]);

    let categories = await getCategories(db);
    let body_keys = Object.keys(body);
    let category_ids = [];

    for (const row of categories) {
        if (body_keys.includes(`${row.kategori_id}`)) {
            category_ids.push(row.kategori_id);
        }
    }
    sql = "CALL delete_categories4product(?)";
    await db.query(sql, [body.id]);
    category_ids.forEach(async function(id) {
        let sql = "CALL add_product2category(?,?)";

        await db.query(sql, [body.id, id]);
    });
}


/**
 * Deactivate product with specific id.
 *
 * @async
 * @param {int} Product id.
 *
 * @returns {void}
 */
async function deactivateProduct(db, product_id) {
    let sql = "CALL delete_product(?)";
    await db.query(sql, [product_id]);
}


/**
 * Activate product with specific id.
 *
 * @async
 * @param {int} Product id.
 *
 * @returns {void}
 */
async function activateProduct(db, product_id) {
    let sql = "CALL activate_product(?)";
    await db.query(sql, [product_id]);
}


/**
 * Permanently delete product with specific id.
 *
 * @async
 * @param {int} Product id.
 *
 * @returns {void}
 */
async function deleteProduct(db, product_id) {
    let sql = "CALL delete_product_permanently(?)";
    await db.query(sql, [product_id]);
}


/**
 * Fetch category "id".
 *
 * @async
 * @param {int} Category id.
 *
 * @returns {void}
 */
async function getCategory(db, category_id) {
    let sql = "CALL get_category(?)";
    let res = await db.query(sql, [category_id]);

    return res[0];
}


/**
 * Fetch all products in category id.
 *
 * @async
 * @param {int} Category id.
 *
 * @returns {void}
 */
async function getProductsInCat(db, category_id) {
    let sql = "CALL get_product_in_category(?)";
    let res =  await db.query(sql, [category_id]);

    return res[0];
}


/**
 * Get all customers.
 *
 * @async
 * @param {void}.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getCustomers(db) {
    let sql = "CALL get_customers()";
    let res = await db.query(sql);

    return res[0];
}