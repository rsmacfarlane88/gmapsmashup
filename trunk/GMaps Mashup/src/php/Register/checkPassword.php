<?PHP

include("../functions.php");

$connection = dbConnect();

//asign the data passed from Flex to variables
$username = $_POST["username"];
$email = $_POST["email"];
$password = $_POST["password"];


//Query the database to see if the given username/password combination is valid.
$query = mysql_query("SELECT password FROM users WHERE password = '$password'");
$result = mysql_num_rows($query);
$query2 = mysql_query("SELECT username FROM users WHERE username = '$username'");
$result2 = mysql_num_rows($query2);
$query3 = mysql_query("SELECT email FROM users WHERE email = '$email'");
$result3 = mysql_num_rows($query3);


//start outputting the XML
$output = "<CheckData><Data>";


//if the query returned true, the output <loginsuccess>yes</loginsuccess> else output <loginsuccess>no</loginsuccess>
if($result > 0)
{
	$output .= "<password>yes</password>";		
}else{
	$output .= "<password>no</password>";	
}

if($result2 > 0)
{
	$output .= "<username>yes</username>";
}else{
	$output .= "<username>no</username>";
}

if($result3 > 0)
{
	$output .= "<email>yes</email>";
}else{
	$output .= "<email>no</email>";
}

$output .= "</Data></CheckData>";

//output all the XML
print ($output);

?>