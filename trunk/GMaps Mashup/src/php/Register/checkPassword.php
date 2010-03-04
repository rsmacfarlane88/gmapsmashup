<?PHP

include("../functions.php");

$connection = dbConnect();

$result = mysql_query("select * from users");

echo "<?xml version=\"1.0\" ?><userList>";

while($row = mysql_fetch_assoc($result))
{
	echo "<user><username>" . $row["username"] . "</username>";
	echo "<password>" . $row["password"] . "</password>";
	echo "<email>" . $row["email"] . "</email></user>";
}

echo "</userList>";

?>