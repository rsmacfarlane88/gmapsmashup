<?PHP

mysql_connect("localhost", "root","");
mysql_select_db("maps");

$username = $_REQUEST['username'];
$password = $_REQUEST['password'];

$result = mysql_query("SELECT * FROM users WHERE username='$username'");

echo "<?xml version=\"1.0\" ?><users>";

while($row = mysql_fetch_assoc($result))
{
	echo "<users><username>" . $row["username"] . "</username>";
	echo "<password>" . $row["password"] . "</password></users>";
	
}

echo "</users>";

?>