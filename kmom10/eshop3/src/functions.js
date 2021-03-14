/**
 * A collection of useful functions.
 *
 * @author Nenad Cuturic
 */
/* jshint node: true */
/* jshint esversion: 8 */
"use strict";

// const { table } = require("node:console");

module.exports = {
    "aboutMe": aboutMe,
    "getLogs": getLogs,
    "getShelves": getShelves,
    "getInventory": getInventory,
    "addToInventory": addToInventory,
    "removeFromInventory": removeFromInventory,
    "getCategory": getCategory,
    "getCategories": getCategories,
    "getProductsInCat": getProductsInCat,
    "addProduct": addProduct,
    "getProduct": getProduct,
    "getProducts": getProducts,
    "updateProduct": updateProduct,
    "deactivateProduct": deactivateProduct,
    "activateProduct": activateProduct,
    "deleteProduct": deleteProduct,
    "getCustomers": getCustomers,
    "getCustomer": getCustomer,
    "getProductsCategories": getProductsCategories,
    "getOrder": getOrder,
    "getInvoiceByOrderid": getInvoiceByOrderid,
    "getOrders": getOrders,
    "saveOrder": saveOrder,
    "getProductsFromOrderid": getProductsFromOrderid,
    "getProductsFromInvoiceid": getProductsFromInvoiceid,
    "updateOrder": updateOrder,
    "changeOrderStatus": changeOrderStatus,
    "setInvoice2Paid": setInvoice2Paid,
    "showPicklist": showPicklist,
    "getPicklist": getPicklist,
    "shipOrder": shipOrder
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
    // console.log(res);
    // console.log(nrOfLines, search);

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
        let res_as_json = JSON.parse(JSON.stringify(res));

        // console.info(res_as_json[1][0]);
        // console.info(res_as_json[1][0].status);
        if (res_as_json[1][0].status === 0) {
            console.log("Inventory updated!");
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
    let sql = "CALL get_products_in_category(?)";
    let res =  await db.query(sql, [category_id]);

    return res[0];
}


/**
 * Get specific customer.
 *
 * @async
 * @param {int} Customer id.
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getCustomer(db, customer_id) {
    let sql = "CALL get_customer(?)";
    let res = await db.query(sql, [customer_id]);

    return res[0][0];
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


/**
 * Get an order.
 *
 * @async
 * @param {connection}  db connection.
 * @param {int}  Order id.
 * 
 * @returns {void}
 */
async function getOrder(db, order_id) {
    let sql = "CALL get_order(?)";
    let res = await db.query(sql, [order_id]);

    return res[0][0];
}


/**
 * Get an invoice by using Order id.
 *
 * @async
 * @param {connection}  db connection.
 * @param {int}  Order id.
 * 
 * @returns {void}
 */
async function getInvoiceByOrderid(db, order_id) {
    let sql = "CALL get_invoice_by_orderid(?)";
    let res = await db.query(sql, [order_id]);

    return res[0][0];
}


/**
 * Get orders.
 *
 * @async
 * @param {void}.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function getOrders(db, searchStr = "") {
    let sql = "CALL get_orders(?)";
    searchStr = `%${searchStr}%`;

    let res = await db.query(sql, [searchStr]);

    return res[0];
}


/**
 * Save order.
 *
 * @async
 * @param {body} Order details.
 *
 * @returns {int} Order id
 */
async function saveOrder(db, req_body) {
    let products = await getProducts(db);
    let order_rows = [];


    for (const row of products) {
        let antal = req_body[row.id];

        if (antal && antal != '0') {
            order_rows.push(
                {
                    produkt_id: row.id,
                    antal:      antal,
                    pris:       row.pris
                });
        }
    }
    // console.log("orderrader:", order_rows);

    let sql = "CALL create_order(?,@p_bestallning_id); SELECT @p_bestallning_id AS bestallning_id;";

    let res = await db.query(sql, [req_body.kund_id]);
    let res_as_json = JSON.parse(JSON.stringify(res));
    let bestallning_id = res_as_json[1][0].bestallning_id;

    console.log("order_id:", bestallning_id);
    for (const order_row of order_rows) {
        sql = "CALL create_order_row(?,?,?,?)";

        await db.query(sql, [bestallning_id, order_row.produkt_id, order_row.antal, order_row.pris]);
    }
}



/**
 * Get order rows for order id..
 *
 * @async
 * @param {int} Order id.
 *
 * @returns {RowDataPacket} Resultset from the query
 */
async function getProductsFromOrderid(db, order_id) {
    let products = await getProducts(db);
    let order_rows = {};
    let sql = "CALL get_order_rows(?)";
    let expanded_products = [];

    let rows_res = await db.query(sql, [order_id]);

    for (const row of rows_res[0]) {
        order_rows[row.produkt_id] = {
            antal: row.antal,
            pris:  row.pris
        };
    }

    for (const row of products) {
        if (Object.keys(order_rows).includes(`${row.id}`)) {
            row.selected_number = order_rows[row.id].antal;
            if (row.pris !== order_rows[row.id].pris) {
                row.gammalt_pris = order_rows[row.id].pris;
            } else {
                row.gammalt_pris = undefined;
            }
        } else {
            row.selected_number = 0;
        }
        expanded_products.push(row);
    }
    // console.log("expanded_products:", expanded_products);
    return expanded_products;
}



/**
 * Get invoice rows for invoice id..
 *
 * @async
 * @param {int} Invoice id.
 *
 * @returns {RowDataPacket} Resultset from the query
 */
async function getProductsFromInvoiceid(db, invoice_id) {
    let products = await getProducts(db);
    let invoice_rows = {};
    let sql = "CALL get_invoice_rows(?)";
    let expanded_products = [];

    let rows_res = await db.query(sql, [invoice_id]);

    for (const row of rows_res[0]) {
        invoice_rows[row.produkt_id] = {
            antal: row.antal,
            pris:  row.pris
        };
    }

    for (const row of products) {
        if (Object.keys(invoice_rows).includes(`${row.id}`)) {
            row.selected_number = invoice_rows[row.id].antal;
            if (row.pris !== invoice_rows[row.id].pris) {
                row.pris = invoice_rows[row.id].pris;
            }
        } else {
            row.selected_number = 0;
        }
        expanded_products.push(row);
    }
    // console.log("expanded_products:", expanded_products);
    return expanded_products;
}


/**
 * Update existing order.
 *
 * @async
 * @param {int}  Order id.
 * 
 * @returns {void}
 */
 async function updateOrder(db, req_body, order_id) {
    let products = await getProducts(db);
    let sql = "CALL remove_order_rows(?)";
    await db.query(sql, [order_id]);

    let order_rows = [];

    for (const row of products) {
        let antal = req_body[row.id];

        if (antal && antal != '0') {
            order_rows.push(
                {
                    produkt_id: row.id,
                    antal:      antal,
                    pris:       row.pris
                });
        }
    }
    // console.log("orderrader:", order_rows);

    console.log("order_id:", order_id);
    for (const order_row of order_rows) {
        sql = "CALL create_order_row(?,?,?,?)";

        await db.query(sql, [order_id, order_row.produkt_id, order_row.antal, order_row.pris]);
    }


    sql = "CALL change_order_status(?,?)";
    await db.query(sql, [order_id, 'uppdaterad']);
}


/**
 * Change order status.
 *
 * @async
 * @param {connection} db-connection.
 * @param {int}  Order id.
 * @param {string}  status.
 *
 * @returns {void}
 */
async function changeOrderStatus(db, order_id, status) {
    let sql = "CALL change_order_status(?,?)";
    
    await db.query(sql, [order_id, status]);
}


/**
 * Change invoice status.
 *
 * @async
 * @param {connection} db-connection.
 * @param {int}  Invoice id.
 * @param {str} Payment date in YYYY-MM-DD format.
 *
 * @returns {void}
 */
async function setInvoice2Paid(db, invoice_id, payment_date) {
    let sql = "CALL set_invoice_status2paid(?,?,@transaction_status); SELECT @transaction_status AS status;";

    try {
        const p_payment_date = new Date(payment_date);
        const res = await db.query(sql, [invoice_id, p_payment_date]);
        const res_as_json = JSON.parse(JSON.stringify(res));
        if (res_as_json[1][0].status == 1) {
            console.log("Invoice status is updated!\n");
        } else {
            console.log("Wrong invoice id or status is not 'skapad'!\n");
        }
    } catch (err) {
        console.error("Wrong date format!\n", err);
        return;
    }
}


/**
 * Get picklist for given order id.
 *
 * @async
 * @param {int} order id.
 *
 * @returns {picklist|boolean}
 */
 async function getPicklist(db, order_id) {
    let picklist = [];
    let order = await getOrder(db, order_id);

    if (
        order === undefined ||
        !Object.keys(order).includes('status') ||
        order.status !== "beställd"
        ) {
        console.log("Order must exist and have status 'beställd'");
        return false;
    }

    let sql = "CALL get_shelves_with_products(?)";
    let res_shelves = await db.query(sql, [order_id]);

    sql = "CALL get_order_rows(?)";
    let res_order_rows = await db.query(sql, [order_id]);

    let obj_len = Object.keys(res_shelves[0]).length;
    let count = 0;

    let shelf_row = res_shelves[0][count];
    sql = "CALL get_product(?)";

    for (const order_row of res_order_rows[0]) {
        let nr_on_shelf = 0;
        let obj = {
            ProductID: order_row.produkt_id,
            "Product name": undefined,
            "Ordered": order_row.antal,
            "Nr on shelf": 0,
            "Number to pick": 0,
            "From shelf": ""
        };
        let to_pick = 0;
        let not_added = true;

        while (count < obj_len) {
            if (order_row.produkt_id === shelf_row.produkt_id) {
                if (shelf_row.antal > 0) {
                    nr_on_shelf += shelf_row.antal;
                    if (nr_on_shelf <= order_row.antal) {
                        to_pick = shelf_row.antal;
                    } else {
                        to_pick = order_row.antal - to_pick;
                    }
                    obj["From shelf"] = shelf_row.hylla_id;
                    obj["Number to pick"] = to_pick;
                    obj["Product name"] = shelf_row.produktnamn;
                    obj["Nr on shelf"] = shelf_row.antal;
                    picklist.push(JSON.parse(JSON.stringify(obj)));
                    not_added = false;
                }
            } else if (shelf_row.produkt_id > order_row.produkt_id) {
                break;
            }
            count += 1;
            shelf_row = res_shelves[0][count];
        }
        if (not_added) {
            let produkt = await db.query(sql, [order_row.produkt_id]);
            obj["Product name"] = produkt[0][0].produktnamn;
            picklist.push(JSON.parse(JSON.stringify(obj)));
        }
    }

    let res_picklist = [];
    res_picklist.push(picklist);
    res_picklist.push(order.kund_id);

    return res_picklist;
}


/**
 * Show picklist for given order id.
 *
 * @async
 * @param {int} order id.
 *
 * @returns {void}
 */
async function showPicklist(db, order_id) {
    let res_picklist = await getPicklist(db, order_id);
    if (!res_picklist) {
        return;
    }
    let picklist = res_picklist[0];
    let kund_id = res_picklist[1];

    console.log("\n\n+-----------+");
    console.log("| PICKLIST  |", "  Order id:", order_id, "  Kund id:", kund_id);
    const max_lengths = createMaxLengths(picklist);
    console.log(showTable(picklist, max_lengths));
}


/**
 * Output resultset as formatted table.
 *
 * @param {Array} res Resultset with details on from database query.
 *
 * @returns {string} Formatted table to print out.
 */
 function showTable(res, columns_and_lengths) {
    const tableHeader = {
        "ProductID":       "end",
        "Product name":    "start",
        "Ordered":         "end",
        "Nr on shelf":     "end",
        "Number to pick":  "end",
        "From shelf":      "start"
    };
    const maxLengths = Object.values(columns_and_lengths),
          columns = Object.keys(columns_and_lengths),
          coumnNames = Object.keys(tableHeader),
          columnPaddings = Object.values(tableHeader);

    let str1 = "+",
        str2 = "|",
        str3 = "";

    maxLengths.forEach(function (item, index) {
        let max = Math.max(maxLengths[index], coumnNames[index].length);

        str1  += "-".repeat(max + 2) + "+";
        str2  += " " + coumnNames[index] + " ".repeat(max - coumnNames[index].length) + " |";
    });
    str1 += "\n";
    str2 += "\n";
    for (const row of res) {
        let rowValue;

        str3 += "| ";
        columnPaddings.forEach(function (item, index) {
            let max = Math.max(maxLengths[index], coumnNames[index].length);

            rowValue = "" + row[columns[index]];
            if (item === "start") {
                str3 += rowValue.padEnd(max) + " | ";
            } else {
                str3 += rowValue.padStart(max) + " | ";
            }
        });
        str3 += "\n";
    }
    str1 += str2 + str1 + str3 + str1;
    return str1;
}


/**
 * Get information about column max lengths.
 *
 * @param {dict} picklist dictionary.
 *
 * @returns {dic} Columns with its nax lengths inclusive column names lengths.
 */
function createMaxLengths(picklist) {
    let column_maxlengths = {};
    let keys = Object.keys(picklist[0]);

    for (const key of keys) {
        column_maxlengths[key] = key.length;
    }
    for (const row of picklist) {
        for (const key of keys) {
            if (`${row[key]}`.length > column_maxlengths[key]) {
                column_maxlengths[key] = `${row[key]}`.length;
            }
        }
    }
    return column_maxlengths;
}


/**
 * Check if order can be shipped.
 *
 * @param {int} order id.
 *
 * @returns {boolean}
 */
function isShippable(picklist) {

    for (const row of picklist) {
        if (row["Number to pick"] === 0) {
            return false;
        }
    }
    return true;
}


/**
 * Ship order for given order id.
 *
 * @async
 * @param {int} order id.
 *
 * @returns {void}
 */
async function shipOrder(db, order_id) {
    let order = await getOrder(db, order_id);

    if (
        order === undefined ||
        !Object.keys(order).includes('status') ||
        order.status !== "beställd"
        ) {
        console.log("Order must exist and have status 'beställd'");
        return;
    }
    let res_picklist = await getPicklist(db, order_id);
    let picklist = res_picklist[0];

    if (!isShippable(picklist)) {
        console.info("Some items are missing in the inventory!");
        console.info(`Run 'picklist ${order_id}' command to find out which.`);
        return;
    }

    for (const row of picklist) {
        let list = [row.ProductID, row["From shelf"], row["Number to pick"]];
        await removeFromInventory(db, list);
    }

    let sql = "CALL create_invoice(?)";
    
    await db.query(sql, [order_id]);
    console.log("Order shipped and invoice created.");
}
