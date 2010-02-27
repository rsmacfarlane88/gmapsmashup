package custom
{
	import flash.display.Bitmap;
	
	public class CustomIcons
	{
		//This declares all of the images I would like to use as icons
		//and embeds them into the .swf file.
		[Embed(source="/../images/uni.png")]
		public var uniBuilding:Class;
		[Embed(source="../images/bed.png")]
		public var accommodation:Class;
		[Embed(source="../images/shop.png")]
		public var shop:Class;
		[Embed(source="../images/food.png")]
		public var food:Class;
		[Embed(source="../images/entertain.png")]
		public var entertainment:Class;
		[Embed(source="../images/bank.png")]
		public var bank:Class;
		[Embed(source="../images/computer.png")]
		public var computer:Class;
		[Embed(source="../images/bus.png")]
		public var bus:Class;
		[Embed(source="../images/park_icon.png")]
		public var parking:Class;
		[Embed(source="../images/globe.png")]
		public var all:Class;
		
		
		
		/**
		 * @description
		 * This function takes in a category from the array of markers and
		 * returns an icon based on the type of category. The icon is then 
		 * displayed as the markers current icon.
		 * 
		 * @param category:integer
		 * @return bm:Bitmap
		 * 
		 */		
		public function chooseIcon(category:int):Bitmap{
			var cat:int = category;
			
			if(cat == 1){
				var bm:Bitmap = new uniBuilding as Bitmap;
			}else if(cat == 2){
				var bm:Bitmap = new accommodation as Bitmap;
			}else if(cat == 3){
				var bm:Bitmap = new shop as Bitmap;
			}else if(cat == 4){
				var bm:Bitmap = new food as Bitmap;
			}else if(cat == 5){
				var bm:Bitmap = new entertainment as Bitmap;
			}else if(cat == 6){
				var bm:Bitmap = new bank as Bitmap;
			}else if(cat== 7){
				var bm:Bitmap = new computer as Bitmap;
			}else if(cat == 8){
				var bm:Bitmap = new bus as Bitmap;
			}else if(cat == 9){
				var bm:Bitmap = new parking as Bitmap;
			} 
			
			return bm;
		} 
	}
}