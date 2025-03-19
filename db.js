
async function connect() {
    if (global.connection) {
        return global.connection;
    }

    const { Client } = require('pg');
    const conn = new Client({
        host: 'localhost',
        database: 'efeira_agroecologica',
        user: 'postgres',
        password: '123456',
        port: 5433,
    });

    await conn.connect();
    console.log("Criou conn de conexões no PostgreSQL!");

    // Armazenando a conexão globalmente para reutilização
    global.connection = conn;
    return conn;
}


async function executeCustomQuery(query) {
    const client = await connect();
    const res = await client.query(query.query);

    console.log('');
    console.log('');
    console.log(query.title);
    console.log('');
    return formatData(res.rows);
}

async function formatData(rows) {
    if (rows.length !== 0) {
        let formattedRow = ''
        let headers = ''
        Object.keys(rows[0]).map((key) => {
            headers += key + ' | '
        })

        console.log(headers);
        console.log('');

        rows.map((row) => {
            formattedRow = ''
            Object.keys(row).map((key) => {
                formattedRow += row[key] + ' | '
            })
            console.log(formattedRow);
        })
    } else {
        console.log('Não há dados a serem exibidos!');
        console.log('');
    }

}

module.exports = { executeCustomQuery, connect }