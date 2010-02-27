package custom
{
	public class PasswordGenerator
	{
		public function PasswordGenerator()
		{
		}
		
		public function generatePassword(length:int):String
		{
			var _length:int = length;
			var letters:String = "abcdefghijklmnpqrstuvwxyz1234567890";
			var letter_List:Array = letters.split("");
			var password:String = "";
			
			for (var i:int = 0; i < _length; i++)
			{
				password += letter_List[int(Math.floor(Math.random() * letter_List.length))];

			}
			return password;
		}

	}
}