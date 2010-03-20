<?PHP
include("../functions.php");

$connection = dbConnect();

$name = $_POST['name'];
$description = $_POST['description'];
$category = $_POST['category'];
$encoded_line = $_POST['encoded_line'];

$insert = "INSERT INTO route(name,description,category,encoded_line) VALUES ('$name','$description','$category','$encoded_line');";
$resultID = mysql_query($insert) or die("Error inserting data into Route table");


?>