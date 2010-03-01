package custom
{
	import com.google.maps.LatLng;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.Polyline;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.HBox;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.RadioButton;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.rpc.http.HTTPService;


	public class RouteMapper extends UIComponent
	{
		private var testPoint:Marker;
    	public var polyLatLngs:Array = new Array();
    	private var polyShape;
	
		private var route_controller:HBox;
		private var drawmode_polyline:RadioButton;
		private var clearMap:Button;
		private var deleteLast:Button;
		private var endRoute:Button;
		 
		
		public function RouteMapper()
		{
			route_controller = new HBox();
			clearMap = new Button();
			deleteLast = new Button();
			endRoute = new Button();
			
			//route controller
			route_controller.width = 220;
			route_controller.height = 30;
			route_controller.x = 0;
			route_controller.y = 0;
			route_controller.visible = true;
			
			//clear map button
			clearMap.label = "Clear Map";
			clearMap.width = 100;
			clearMap.height = 20;
			clearMap.x = 5;
			clearMap.y = 5;
			clearMap.addEventListener(MouseEvent.CLICK, clearMap2);
			route_controller.addChild(clearMap);
			
			//delete last button
			deleteLast.label = "Delete Last";
			deleteLast.width = 100;
			deleteLast.height = 20;
			deleteLast.x = 110;
			deleteLast.y = 5;
			deleteLast.addEventListener(MouseEvent.CLICK, deleteLastLatLng);
			route_controller.addChild(deleteLast);
			
			//endRoute button
			endRoute.label = "End Route";
			endRoute.width = 100;
			endRoute.height = 20;
			endRoute.x = 220;
			endRoute.y = 5;
			endRoute.addEventListener(MouseEvent.CLICK, routeEnd);
			route_controller.addChild(endRoute);
			
			//Application.application.map.addEventListener(MapMouseEvent.CLICK, mapClick);
			
			addChild(route_controller);
		}
		
		public function mapClick(e:MapMouseEvent):void {
        	var latlngClicked:LatLng = e.latLng;
            polyLatLngs.push(latlngClicked);
            drawCoordinates();
        }
                 
        private function deleteLastLatLng(e:Event):void {
        	if (polyLatLngs.length > 0) {
            	polyLatLngs.pop();
          	}
          	
          	drawCoordinates();
     	}
                 
     	// Clear current Map
      	private function clearMap2(e:Event):void {
        	Application.application.map.clearOverlays();
        	polyShape = null;
       		polyLatLngs.length = 0;
    	}


       	private function drawCoordinates():void {
        	Application.application.map.clearOverlays();
           	if (polyLatLngs.length > 1) {
            	
                	polyShape = new Polyline(polyLatLngs);
              	
            	
            	Application.application.map.addOverlay(polyShape);
        	}
           
           	if (polyLatLngs.length > 0) {
              	// Grab last point of polyPoints to add new marker
              	var tmpLatLng:LatLng = polyLatLngs[polyLatLngs.length -1];
              	Application.application.map.addOverlay(new Marker(tmpLatLng));
          	}
       	}
     	
     	public function routeEnd(e:MouseEvent):void
     	{
     		var addRoute:RouteDetailsDialog = new RouteDetailsDialog();
     		
 			Alert.show("You have finished mapping a route.\n" + 
 					"You will have the choice to save it to the database.",
 					"End of Route",
 					Alert.OK);
 					
 			removeChild(route_controller);
 			addRoute.x = (Application.application.map.width/2)-(addRoute.width/2);
 			addRoute.y = (Application.application.map.height/2)-(addRoute.height/2);
 			Application.application.map.addChild(addRoute);
 			Application.application.map.removeEventListener(MapMouseEvent.CLICK, mapClick);
     	}
     }
}
	
