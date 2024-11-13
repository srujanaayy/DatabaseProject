/* getdata1a.php */
//need to add a select statement, database name and password
?php
$eid = $_GET['EID'];
$pwd = $_GET['Password'];

//new mysqli(name of host, mySQL username, password, name of database)
$conn = new mysqli("localhost", "root", "password", "db");

$sql = "SELECT 
        FROM
        WHERE"

$result = $conn->query($sql);
if($result) {
  while($row = $result --> fetch_assoc()) {
    printf(); //print attributes
  }
  $result->free();
}
$conn->close();
