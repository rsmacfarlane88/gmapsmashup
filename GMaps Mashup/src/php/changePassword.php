<?PHP
include ("functions.php");

$connection = dbConnect();

$username=$_POST['username'];
$currentPass=$_POST['currentPassword'];
$newPass=$_POST['newPassword'];

//$updateQuery = "UPDATE users SET password='$newPass' WHERE username='$username';";
////$updateQuery = "INSERT INTO users(password) VALUES('Test') WHERE username='Rosco' ;";
//$updateResult = mysql_query($updateQuery);


$checkQuery = "SELECT password FROM users WHERE username='$username'"; 
$checkResult = mysql_fetch_array(mysql_query($checkQuery));
$pass = $checkResult[0];

if($pass == $currentPass)
{
	$updateQuery = "UPDATE users SET password='$newPass'
					WHERE username='$username'";
	$updateResult = mysql_query($updateQuery);
	$output = "<success>yes</success>";
}else{
	$output = "<success>no</success>";
	
}

print ($output);

?>