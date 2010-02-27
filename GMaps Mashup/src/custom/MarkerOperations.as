package custom
{
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.overlays.*;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
    	
	public class MarkerOperations
	{
		
		
		public function MarkerOperations()
		{
		}

		
		public function createMarker(m:Marker, o:InfoWindowOptions, array:ArrayCollection, index:int, map:Map):void
			{
				var myMap:Map = map;
				var list:ArrayCollection = array;
				var i:int = index;
				
				m.addEventListener(MapMouseEvent.CLICK, function(e:Event):void {
                		//this.customUI.txtTitle.text = list[i].name;
                		m.openInfoWindow(o);
                	});
                	
                //myMap.addOverlay(m);
               	
			}
	}
}