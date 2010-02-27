<?PHP

//Used to hide mysql login details
include ("../functions.php");

$connection = dbConnect();

//asign the data passed from Flex to variables
$username = mysql_real_escape_string($_POST["username"]);
$password = mysql_real_escape_string($_POST["password"]);

//Query the database to see if the given username/password combination is valid.
$query = "SELECT * FROM users WHERE username = '$username' AND password = '$password'";
$result = mysql_fetch_array(mysql_query($query));

//start outputting the XML
$output = "<loginsuccess>";

//if the query returned true, the output <loginsuccess>yes</loginsuccess> else output <loginsuccess>no</loginsuccess>
if(!$result)
{
	$output .= "no";		
}else{
	$output .= "yes";	
}

$output .= "</loginsuccess>";

//output all the XML
print ($output);

?>
