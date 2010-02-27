package custom
{
	import flash.display.Bitmap;
	
	import mx.collections.ArrayCollection;
	
	public class CustomIcons
	{
		//This declares all of the images I would like to use as icons
		//and embeds them into the .swf file.
		[Embed(source="/../images/uni.png")]
		public var icon1:Class;
		[Embed(source="../images/bed.png")]
		public var icon2:Class;
		[Embed(source="../images/shop.png")]
		public var icon3:Class;
		[Embed(source="../images/food.png")]
		public var icon4:Class;
		[Embed(source="../images/entertain.png")]
		public var icon5:Class;
		[Embed(source="../images/bank.png")]
		public var icon6:Class;
		[Embed(source="../images/computer.png")]
		public var icon7:Class;
		[Embed(source="../images/bus.png")]
		public var icon8:Class;
		[Embed(source="../images/park_icon.png")]
		public var icon9:Class;
		
		
		
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
				var bm:Bitmap = new icon1 as Bitmap;
			}else if(cat == 2){
				var bm:Bitmap = new icon2 as Bitmap;
			}else if(cat == 3){
				var bm:Bitmap = new icon3 as Bitmap;
			}else if(cat == 4){
				var bm:Bitmap = new icon4 as Bitmap;
			}else if(cat == 5){
				var bm:Bitmap = new icon5 as Bitmap;
			}else if(cat == 6){
				var bm:Bitmap = new icon6 as Bitmap;
			}else if(cat== 7){
				var bm:Bitmap = new icon7 as Bitmap;
			}else if(cat == 8){
				var bm:Bitmap = new icon8 as Bitmap;
			}else if(cat == 9){
				var bm:Bitmap = new icon9 as Bitmap;
			} 
			
			return bm;
		} 
	}
}