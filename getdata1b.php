/* getdata1b.php */
//need to add a update statement, database name and password
?php
$eid = $_GET['EID'];
$pwd = $_GET['Password'];

//new mysqli(name of host, mySQL username, password, name of database)
$conn = new mysqli("localhost", "root", "password", "db");

$sql = "UPDATE
        SET
        WHERE"

$result = $conn->query($sql);
$conn->close();
