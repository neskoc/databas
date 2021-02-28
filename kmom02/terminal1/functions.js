/**
 * A collection of useful functions.
 *
 * @author Nenad Cuturic
 */
"use strict";

module.exports = {
    "getMaxLengths": getMaxLengths,
    "teacherAsTable": teacherAsTable,
    "searchTeachers": searchTeachers,
    "getTeachers": getTeachers,
    "searchMinMax": searchMinMax,
    "getTeachers2": getTeachers2
};


/**
 * Get information about column max lengths.
 *
 * @async
 * @param {connection} db Database connection.
 *
 * @returns {json object} Formatted table to print out.
 */
async function getMaxLengths(db) {
    let sql;
    let res;

    sql = `
        SELECT
            MAX(CHAR_LENGTH(akronym)) AS akronym,
            MAX(CHAR_LENGTH(fornamn)) AS fornamn,
            MAX(CHAR_LENGTH(efternamn)) AS efternamn,
            MAX(CHAR_LENGTH(avdelning)) AS avdelning,
            MAX(CHAR_LENGTH(lon)) AS lon,
            MAX(CHAR_LENGTH(kompetens)) AS kompetens,
            MAX(CHAR_LENGTH(fodd)) AS fodd
        FROM larare;
    `;
    res = await db.query(sql);
    return JSON.parse(JSON.stringify(res));
}

/**
 * Output resultset as formatted table with details on teachers.
 *
 * @param {Array} res Resultset with details on from database query.
 *
 * @returns {string} Formatted table to print out.
 */
function teacherAsTable(res) {
    let str;

    str  = "+---------+---------------------+------+---------+------+------------+\n";
    str += "| Akronym | Namn                | Avd  |   Lön   | Komp | Född       |\n";
    str += "|---------|---------------------|------|---------|------|------------|\n";
    for (const row of res) {
        str += "| ";
        str += row.akronym.padEnd(7);
        str += " | ";
        str += (row.fornamn + " " + row.efternamn).padEnd(19);
        str += " | ";
        str += row.avdelning.padEnd(4);
        str += " | ";
        str += row.lon.toString().padStart(7);
        str += " | ";
        str += row.kompetens.toString().padStart(4);
        str += " | ";
        str += row.fodd.toString().padStart(10);
        str += " |\n";
    }
    str += "+---------+---------------------+------+---------+------+------------+\n";
    return str;
}


/**
 * Output resultset as formatted table with details on teachers.
 *
 * @param {Array} res Resultset with details on from database query.
 *
 * @returns {string} Formatted table to print out.
 */
function showTable(res, tableHeader, maxLengths) {
    let str1 = "+",
        str2 = "|",
        str3 = "";
    const columns = Object.keys(JSON.parse(JSON.stringify(res[0]))),
        coumnNames = Object.keys(tableHeader),
        columnPaddings = Object.values(tableHeader);

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
 * Output resultset as formatted table with details on a teacher.
 *
 * @async
 * @param {connection} db     Database connection.
 *
 * @returns {string} Formatted table to print out.
 */
async function getTeachers(db) {
    let sql;
    let res;
    let str;

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            lon,
            kompetens,
            fodd
        FROM larare
        ORDER BY akronym;
    `;
    res = await db.query(sql);
    str = teacherAsTable(res);
    return str;
}

/**
 * Output resultset as formatted table with details on a teacher.
 *
 * @async
 * @param {connection} db     Database connection.
 *
 * @returns {string} Formatted table to print out.
 */
async function getTeachers2(db, columns, maxLengths) {
    let sql;
    let res;
    let str;

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            lon,
            kompetens,
            fodd
        FROM larare
        ORDER BY akronym;
    `;
    res = await db.query(sql);
    str = showTable(res, columns, maxLengths);
    return str;
}

/**
 * Output resultset as formatted table with details on a teacher.
 *
 * @async
 * @param {connection} db     Database connection.
 * @param {string}     search String to search for.
 *
 * @returns {string} Formatted table to print out.
 */
async function searchTeachers(db, search) {
    let sql;
    let res;
    let str;
    let like = `%${search}%`;

    console.info(`Searching for: ${search}`);

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            lon,
            kompetens,
            fodd
        FROM larare
        WHERE
            akronym LIKE ?
            OR avdelning LIKE ?
            OR fornamn LIKE ?
            OR efternamn LIKE ?
            OR kompetens LIKE ?
        ORDER BY akronym;
    `;
    res = await db.query(sql, [like, like, like, like, like]);
    str = teacherAsTable(res);
    return str;
}

/**
 * Search between two values, limited to lön and kompetens
 * Output resultset as formatted table with details on a teacher.
 *
 * @async
 * @param {connection} db        Database connection.
 * @param {int}     searchMin Lower limit for search.
 * @param {int}     searchMax Upper limit for search.
 *
 * @returns {string} Formatted table to print out.
 */
async function searchMinMax(db, searchMin, searchMax) {
    let sql;
    let res;
    let str;

    console.info(`Searching for values between ${searchMin} and ${searchMax}`);

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            lon,
            kompetens,
            fodd
        FROM larare
        WHERE
            (lon >= ? AND lon <= ?)
            OR
            (kompetens >= ? AND kompetens <= ?)
        ORDER BY akronym;
    `;
    res = await db.query(sql, [searchMin, searchMax, searchMin, searchMax]);
    str = teacherAsTable(res);
    return str;
}
