<?php
$servername = "localhost";
$username = "root";
$password = "password";
$db = "db";

$conn = new mysqli($servername, $username, $password, $db);

$sql = "SELECT CardNumber
        FROM Customer
        WHERE CustomerID = ? ";

//initialize
$CustomerID = 12345;

if($stmt = $conn->prepare($sql)) {
  $stmt->bind_param("i", $CustomerID);
  $stmt->execute();
  $stmt->bind_result($CardNumber);
  while($stmt->fetch()) {
    printf("%d \n", $CardNumber);
    }
}
?>
