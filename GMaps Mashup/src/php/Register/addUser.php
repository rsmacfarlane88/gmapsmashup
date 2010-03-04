<?PHP
header("Content-type: text/xml");
include("../functions.php");

$connection = dbConnect();

$username=$_POST['username'];
$password=$_POST['password'];
$email=$_POST['email'];

$insert = "INSERT INTO users(username,password,email) VALUES ('$username','$password','$email');";
$resultID = mysql_query($insert) or die("Data not found in 'users' table.");

?>