/* getdata1b.php */
//Set shipping fee to 0 if base price greater than 50 dollars
<?php

$cid = $_GET['CustomerID']; //possible injection: 123' OR 1 = 1 #
$pid = $_GET['PaymentID'];


//new mysqli(name of host, mySQL username, password, name of database)
$servername = "localhost";
$username = "root";
$password = "password";
$db = "db";
$conn = new mysqli($servername, $username, $password, $db);

$sql = "UPDATE Payment
        SET ShippingFee = 0
        WHERE CustomerID = '$cid' AND PaymentID = '$pid' AND BasePrice >= 50"

$result = $conn->query($sql);
$conn->close();
?>
