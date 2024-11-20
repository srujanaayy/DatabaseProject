<?php
$servername = "localhost";
$username = "root";
$password = "123";
$db = "commerceDb";

$conn = new mysqli($servername, $username, $password, $db);

$sql = "SELECT CardNumber
        FROM Customer
        WHERE CustomerID = ?";

//initialize
$CustomerID = isset($_GET['CustomerID']) ? $_GET['CustomerID'] : 0;


if($stmt = $conn->prepare($sql)) {
  $stmt->bind_param("i", $CustomerID);
  $stmt->execute();
  $stmt->bind_result($CardNumber);
  if($stmt->fetch()) {
    printf("%s \n", $CardNumber);
    }
    else {
      printf("CustomerID $CustomerID does not exist");
    }
  $stmt->close();
}
$conn->close();
?>
