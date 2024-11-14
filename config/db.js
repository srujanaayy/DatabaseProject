// const sql = require("mssql");
// require("dotenv").config();

// const config = {
//   server: process.env.DB_SERVER,
//   database: process.env.DB_NAME,
//   user: process.env.DB_USER,
//   password: process.env.DB_PASSWORD,
//   options: {
//     encrypt: true,
//     trustServerCertificate: false,
//   },
// };
// const pool = new sql.ConnectionPool(config);
// const poolConnect = pool.connect();

// poolConnect
//   .then(() => {
//     console.log("Connected to SQL Server successfully");
//   })
//   .catch((err) => {
//     console.error("Database connection failed:", err);
//     process.exit(1);
//   });

// module.exports = { pool, poolConnect };
const mysql = require("mysql2");

const db = mysql.createConnection({
  host: "localhost",
  user: "your-username",
  password: "your-password",
  database: "commerceDb",
});

db.connect((err) => {
  if (err) throw err;
  console.log("Connected to the commerceDb database.");
});

module.exports = db;
