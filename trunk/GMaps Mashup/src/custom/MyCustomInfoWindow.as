package custom
{
import com.google.maps.InfoWindowOptions;
import com.google.maps.LatLng;
import com.google.maps.LatLngBounds;
import com.google.maps.interfaces.IPolyline;
import com.google.maps.overlays.Marker;
import com.google.maps.services.Directions;
import com.google.maps.services.DirectionsEvent;
import com.google.maps.services.Route;
import com.google.maps.services.Step;

import flash.events.Event;
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.containers.Canvas;
import mx.containers.TabNavigator;
import mx.controls.Alert;
import mx.controls.Button;
import mx.controls.ComboBox;
import mx.controls.Image;
import mx.controls.Label;
import mx.controls.LinkButton;
import mx.controls.TextArea;
import mx.core.Application;
import mx.core.UIComponent;
import mx.events.ListEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;



public class MyCustomInfoWindow extends UIComponent {

  public var link2:Button;
  [Bindable]public var routeList:ComboBox;
  [Bindable]public var routeNoList:ArrayCollection = new ArrayCollection();
  [Bindable] public var directionsSteps:ArrayCollection = new ArrayCollection();
  public var routeNo:String= "";
  private var _lat:String = "";
  private var _lng:String = "";
  private var entranceLatLng:String = "55.912091,-3.313339";
  public var tabNav:TabNavigator = new TabNavigator();
  
 public function MyCustomInfoWindow(title:String, picture:String, description:String, lat:String, lng:String) {
 	
    tabNav.width = 320;
    tabNav.height = 225;

    _lat = lat;
    _lng = lng;
    tabNav.addChild(createInfoWindow(title, picture, description));
    tabNav.addChild(createImageWindow(picture));
    tabNav.addChild(createVideoWindow());
    addChild(tabNav);
    cacheAsBitmap = true;
    
 }
  
 public function createInfoWindow(title:String, picture:String, description:String):Canvas {
      var can:Canvas = new Canvas();
      can.width = 315;
      can.height = 220;
      can.label = "Info";
      
      var close:LinkButton = new LinkButton();
      close.x = 280;
      close.y = 5;
      close.label = "X";
      close.addEventListener(MouseEvent.CLICK, function(e:Event):void {
                		Application.application.map.closeInfoWindow();
                	});
      
      var heading:Label = new Label();
      heading.height = 20;
      heading.x = 5;
      heading.y = 5;
      heading.width = 280;
      heading.text = title;
      
      var desc:TextArea = new TextArea();
      desc.editable = false;
      desc.selectable = false;
      desc.x = 5;
      desc.y = 25;
      desc.width = 110;
      desc.height = 90;
      desc.htmlText = description;
      desc.setStyle("borderStyle", "none");
      
      var image:Image = new Image();
      image.width = 150;
      image.height = 120;
      image.x = 120;
      image.y = 25;
      image.visible = true;
      image.source = picture;
      
      var link1:LinkButton = new LinkButton();
      link1.width = 80;
      link1.height = 15;
      link1.x = 5;
      link1.y = 170;
      link1.addEventListener(MouseEvent.CLICK, openDirections);
      link1.addEventListener(MouseEvent.CLICK, directionsClick);
      link1.label = "Directions";
      
                	      
      link2 = new Button();
      link2.width = 90;
      link2.height = 15;
      link2.x = 200;
      link2.y = 170;
      link2.addEventListener(MouseEvent.CLICK, showPage);
      link2.label = "Timetable";
      link2.visible = false;
      
      routeList = new ComboBox();
      routeList.width = 50;
      routeList.height = 15;
      routeList.x = 90;
      routeList.y = 170;
      routeList.addEventListener(ListEvent.CHANGE, onSelect);
      routeList.selectedIndex = 0;
      routeList.visible = false;
      
      can.addChild(close);
      can.addChild(heading);
      can.addChild(image);
      can.addChild(desc);
      can.addChild(link1);
      can.addChild(link2);
      can.addChild(routeList);
      
      return can;
 }
 
 private function createImageWindow(picture:String):Canvas
 {
 	var can:Canvas = new Canvas();
      can.width = 315;
      can.height = 220;
      can.label = "Images";
      
      var close:LinkButton = new LinkButton();
      close.x = 280;
      close.y = 5;
      close.label = "X";
      close.addEventListener(MouseEvent.CLICK, function(e:Event):void {
                		Application.application.map.closeInfoWindow();
                	});
                	
      var image:Image = new Image();
      image.width = 250;
      image.height = 200;
      image.x = 5;
      image.y = 5;
      image.visible = true;
      image.source = picture;          	
      
      can.addChild(close);
      can.addChild(image);
      
      return can;
 }
 
 private function createVideoWindow():Canvas
 {
 	var can:Canvas = new Canvas();
      can.width = 315;
      can.height = 220;
      can.label = "Videos";
      
      var close:LinkButton = new LinkButton();
      close.x = 280;
      close.y = 5;
      close.label = "X";
      close.addEventListener(MouseEvent.CLICK, function(e:Event):void {
                		Application.application.map.closeInfoWindow();
                	});
                	
                	
      
      can.addChild(close);
      
      return can;
 }
  
 private function showPage(e:MouseEvent):void
 {
 	Application.application.busNo = routeList.selectedLabel;
  	var page:TimetableViewer = new TimetableViewer();
  	Application.application.addChild(page);
 }
 
 
 private function openDirections(e:Event):void
 {
 	
 	Application.application.filter.sidebar.selectedIndex = 1;
 	
 }
 private function directionsClick(e:Event):void
 {
 	
	
	var directions:Directions = new Directions();
    directions.addEventListener(DirectionsEvent.DIRECTIONS_SUCCESS, onDirectionsSuccess);
    directions.addEventListener(DirectionsEvent.DIRECTIONS_FAILURE, onDirectionsFail);
    directions.load("from: " + entranceLatLng + " to: " + _lat+","+_lng);
   
    //
 }
 
 private function onResult(e:ResultEvent):void
 {
  	routeNoList = e.result.routeNo.bus_routeNo;
  	routeList.dataProvider = routeNoList;
  	routeList.labelField = "route";
 }
 
 private function onSelect(e:Event):void
 {
 	routeNo = routeList.selectedLabel;
 }
  
 public function fetchRouteNo(markerID:String):void
 {
  	var _markerID:String = markerID;
  	var service:HTTPService = new HTTPService();
  	var params:Object = new Object();
	
	params.markerID = _markerID;
  	service.method = "POST";
  	service.url = "php/BusTimetable/getRouteNo.php";
  	service.addEventListener(ResultEvent.RESULT, onResult);
  	service.send(params);
  	
 }
 
 private function onDirectionsFail(event:DirectionsEvent):void {
	Alert.show("Status: " + event.directions.status);
 }        
  
 private function onDirectionsSuccess(event:DirectionsEvent):void {
 	
    Application.application.map.clearOverlays();
    directionsSteps.removeAll();
    
    var directions:Directions = event.directions;
    var directionsPolyline:IPolyline = directions.createPolyline();
    Application.application.map.addOverlay(directionsPolyline);
    
    
    var directionsBounds:LatLngBounds = directionsPolyline.getLatLngBounds();
    Application.application.map.setCenter(directionsBounds.getCenter());
    Application.application.map.setZoom(Application.application.map.getBoundsZoomLevel(directionsBounds));
    
    var startLatLng:LatLng = directions.getRoute(0).getStep(0).latLng;
    var endLatLng:LatLng = directions.getRoute(directions.numRoutes-1).endLatLng;
    Application.application.map.addOverlay(new Marker(startLatLng));
    Application.application.map.addOverlay(new Marker(endLatLng));
    
    Application.application.filter.directionsGrid.dataProvider = directionsSteps;
    Application.application.filter.directionsGrid.addEventListener(ListEvent.ITEM_CLICK, onGridClick);
                   
    for (var r:Number = 0 ; r < directions.numRoutes; r++ ) {
        var route:Route = directions.getRoute(r);
		
    	for (var s:Number = 0 ; s < route.numSteps; s++ ) {
            var step:Step = route.getStep(s);
            directionsSteps.addItem(step);
        }
        
    }
    
    
    
    
    
  }
  
  private function onGridClick(event:Event):void {
    var latLng:LatLng = Application.application.filter.directionsGrid.selectedItem.latLng;
    var opts:InfoWindowOptions = new InfoWindowOptions();
    opts.contentHTML = Application.application.filter.directionsGrid.selectedItem.descriptionHtml;
    Application.application.map.openInfoWindow(latLng, opts);
  }


}

}