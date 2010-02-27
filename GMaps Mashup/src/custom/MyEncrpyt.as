package custom
{
	import com.hurlant.crypto.hash.HMAC;
	
	import flash.utils.ByteArray;
	
	public class MyEncrpyt
	{
		public var key:String = "crackdown";
		public function MyEncrpyt()
		{
		}

		public function encryptPassword(password:String):String{
			var encryptMe:HMAC;
			var pass:ByteArray = password;
			var myKey:ByteArray = key;
			var encrypted:String;
			
			encrypted = encryptMe.compute(myKey,pass);
			
			return encrypted;

		}
	}
}