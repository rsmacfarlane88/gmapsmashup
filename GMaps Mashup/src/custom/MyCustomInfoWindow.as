package custom
{
import flash.events.Event;
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.containers.Canvas;
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
              
  //public var canvas:Canvas = new Canvas();
  public var link2:Button;
  [Bindable]public var routeList:ComboBox;
  [Bindable]public var routeNoList:ArrayCollection = new ArrayCollection();
  public var routeNo:String= "";
  
 public function MyCustomInfoWindow(title:String, picture:String, description:String) {
    // Add body text
    //canvas.width = 310;
    //canvas.height = 210;
    addChild(createInfoWindow(title, picture, description));
    //addChild(canvas);
    cacheAsBitmap = true;
 }
  
 public function createInfoWindow(title:String, picture:String, description:String):Canvas {
      var can:Canvas = new Canvas();
      can.width = 300;
      can.height = 210;
      
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
      link1.label = "Directions";
      
      link2 = new Button();
      link2.width = 90;
      link2.height = 15;
      link2.x = 150;
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
      
      can.addChild(heading);
      can.addChild(image);
      can.addChild(desc);
      can.addChild(link1);
      can.addChild(link2);
      can.addChild(routeList);
      
      return can;
 }
  
 private function showPage(e:MouseEvent):void
 {
 	Application.application.busNo = routeList.selectedLabel;
  	var page:TimetableViewer = new TimetableViewer();
  	Application.application.addChild(page);
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

}

}