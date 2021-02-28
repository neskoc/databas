/**
 * A collection of useful functions.
 *
 * @author Nenad Cuturic
 */
/* jshint node: true */
"use strict";

module.exports = {
    "moveBitcoins": moveBitcoins,
    "findAllInTable": findAllInTable,
    "searchTeachers": searchTeachers,
    "getTeachers": getTeachers,
    "getColumns": getColumns,
    "getCompetencies": getCompetencies,
    "getSalaries": getSalaries,
    "updateTeachersSalary": updateTeachersSalary
};


/**
 * Output is result from db query with details on all teachers.
 *
 * @async
 * @param {connection} db     Database connection.
 *
 * @returns {object} object returned from db query.
 */
async function moveBitcoins(db, amount, fromAccount="2222", toAccount="1111") {
    let table = "account",
        sql = `
            UPDATE ??
            SET
                balance = balance + ?
            WHERE
                id = ?;

            UPDATE ??
            SET
                balance = balance - ?
            WHERE
                id = ?;
        `;

    console.info(`Moving from:${fromAccount} to: ${toAccount}, amount: ${amount}`);

    try {
        await db.beginTransaction();

        await db.query(sql,
            [table, parseFloat(amount), toAccount, table, parseFloat(amount), fromAccount]);

        await db.commit();
        console.log('Success!');
    } catch (err) {
        await db.rollback();
        await db.end();
        return Promise.reject(err);
    }
}

/**
 * Show all entries in the selected table.
 *
 * @async
 * @param {string} table A valid table name.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function findAllInTable(db, table) {
    let sql = `SELECT * FROM ??;`;
    let res;

    res = await db.query(sql, [table]);
    console.info(`SQL: ${sql} (${table}) got ${res.length} rows.`);

    return res;
}


/**
 * Output is result from db query with details on all teachers.
 *
 * @async
 * @param {connection} db     Database connection.
 *
 * @returns {object} object returned from db query.
 */
async function getTeachers(db) {
    let sql,
        res;

    console.info(`Fetching all info about teachers!`);
    sql = `
        SELECT
            *
        FROM v_larare
        ORDER BY akronym;
    `;
    res = await db.query(sql);
    return res;
}

/**
 * Output is result from db query with details on competencies.
 *
 * @async
 * @param {connection} db     Database connection.
 *
 * @returns {object} object returned from db query.
 */
async function getCompetencies(db) {
    let sql,
        res;

    console.info(`Fethcing competencies for all teachers`);
    sql = `
        SELECT
            akronym, fornamn, efternamn, prekomp, nukomp, diffkomp
        FROM v_lonerevision
        ORDER BY nukomp DESC, diffkomp DESC;
    `;
    res = await db.query(sql);
    return res;
}

/**
 * Output is result from db query with details on salaries.
 *
 * @async
 * @param {connection} db     Database connection.
 *
 * @returns {object} object returned from db query.
 */
async function getSalaries(db) {
    let sql,
        res;

    console.info(`Fethcing salaries for all teachers`);
    sql = `
        SELECT
            akronym, fornamn, efternamn, pre, nu, diff, proc, mini
        FROM v_lonerevision
        ORDER BY proc DESC;
    `;
    res = await db.query(sql);
    return res;
}

/**
 * Find info about teacher according to the search criteria.
 *
 * @async
 * @param {connection} db     Database connection.
 * @param {string}     search String to search for.
 *
 * @returns {string} Formatted table to print out.
 */
async function searchTeachers(db, search) {
    let sql,
        res,
        like = `%${search}%`;

    console.info(`Searching for: ${search}`);

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            kon,
            lon,
            kompetens,
            fodd,
            Ålder
        FROM v_larare
        WHERE
            akronym LIKE ?
            OR avdelning LIKE ?
            OR lon LIKE ?
            OR fornamn LIKE ?
            OR efternamn LIKE ?
            OR kompetens LIKE ?
            OR kon LIKE ?
            OR fodd LIKE ?
            OR Ålder LIKE ?
        ORDER BY akronym;
    `;
    res = await db.query(sql, [like, like, like, like, like, like, like, like, like]);
    return res;
}


/**
 * Output is an array with column names for the given table.
 *
 * @async
 * @param {connection} db     Database connection.
 * @param {str} tableName     Table name.
 *
 * @returns {Array} Column names as an array.
 */
async function getColumns(db, tableName) {
    let sql = `SHOW COLUMNS FROM ` + tableName + ";",
        res,
        columnNames = [];

    console.info("Get column names for table " + tableName);
    res = await db.query(sql);
    for (const row of res) {
        const fieldName = {};

        fieldName[row.Field] = "start";
        columnNames.push(fieldName);
    }
    return columnNames;
}



/**
 * Update teachers salary.
 *
 * @async
 * @param {connection} db     Database connection.
 * @param {str} akronym     Teachers acronym.
 * @param {float} lon     Teachers new salary.
 *
 * @returns {object} object returned from db query.
 */
async function updateTeachersSalary(db, akronym, lon) {
    let sql,
        res;

    console.info(`Updating salary to ${lon} for ${akronym}`);
    sql = `UPDATE larare SET lon = ? WHERE akronym = ?;`;
    res = await db.query(sql, [lon, akronym]);
    return res;
}
