<?PHP
include("../functions.php");

$connection = dbConnect();

$latlng = $_POST['latlng'];
$routeID = $_POST['routeID'];


$insert = "INSERT INTO routedata(latlng,routeID) VALUES ('$latlng','$routeID');";
$resultID = mysql_query($insert) or die("Error inserting data into Route table");


?>