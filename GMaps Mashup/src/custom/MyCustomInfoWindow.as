package custom
{
import flash.events.MouseEvent;
import mx.core.Application;
import mx.containers.Canvas;
import mx.controls.Image;
import mx.controls.Label;
import mx.controls.LinkButton;
import mx.controls.TextArea;
import mx.core.UIComponent;


public class MyCustomInfoWindow extends UIComponent {
              
  //public var canvas:Canvas = new Canvas();
  public var link2:LinkButton;
  
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
      desc.width = 100;
      desc.height = 70;
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
      
      link2 = new LinkButton();
      link2.width = 80;
      link2.height = 15;
      link2.x = 90;
      link2.y = 170;
      link2.addEventListener(MouseEvent.CLICK, showPage);
      link2.label = "Timetable";
      link2.visible = false;
      
      can.addChild(heading);
      can.addChild(image);
      can.addChild(desc);
      can.addChild(link1);
      can.addChild(link2);
      
      return can;
  }
  
  private function showPage(e:MouseEvent):void
  {
  	var page:TimetableViewer = new TimetableViewer();
  	Application.application.addChild(page);
  }

}

}