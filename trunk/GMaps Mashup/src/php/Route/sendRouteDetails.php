<?PHP
include("../functions.php");

$connection = dbConnect();

$name = $_POST['name'];
$description = $_POST['description'];
$category = $_POST['category'];

$insert = "INSERT INTO route(name,description,category) VALUES ('$name','$description','$category');";
$resultID = mysql_query($insert, $linkID) or die("Error inserting data into Route table");


?>