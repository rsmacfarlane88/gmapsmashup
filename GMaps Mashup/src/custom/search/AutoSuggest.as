package custom.search
{
/********************************************************************************************************************************************	
 * The AutoSuggest Component behaves similary to the FireFox Search Component. It takes a dataProvider of type ICollectionView
 * and when the user types it displays the closest match to that. If _usingAutoCompleteSuggest is true then it behaves by completing
 * the closest matching word sort of like the openoffice auto completion for a word. This Component will probably be written sometime again
 * with better code and be more flexible.Tried to comment as much as possible
 * 
 * 
 * *****************************************************************************************************************************************/

	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.collections.ICollectionView;
	import mx.controls.ComboBox;
	import mx.controls.Image;
	import mx.core.UIComponent;

	//--------------------------------------
	//  Excluded 
	//--------------------------------------
	/**
	 * @private
	 * Will Always be editable, we do not want
	 * anyone to be able to change this
	 */
	[Exclude(name="editable", kind="property")]
	 //--------------------------------------------------------------------------
    //
    // Begin Class
    //
    //--------------------------------------------------------------------------
	public class AutoSuggest extends ComboBox
	{
		/**
		 * @private
		 * The Picture that is Displayed in the TextInput/Prompt
		 *To DO: CSS
		 */
		 [Embed("../../../images/globe.png")]
		 private var icon:Class;
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
		/**
		 * @private
		 * we use the constructor to set the styles so we make the combobox 
		 * behave as close as we want to a textInput control
		 * 
		 */
		public function AutoSuggest()
		{
			super();
			//make it behave as close as to a textInput as possible
			//setStyle("cornerRadius",0);
			setStyle("arrowButtonWidth",0);
			setStyle("fontWeight","normal");
			setStyle("paddingRight",3);
			setStyle("paddingLeft",0);
			
			//make it editable
			editable=true;
			//we are going to be using the prompt as the input
			selectedIndex=-1;
			//only show the top 5 count
			rowCount=6;
		}
		private var image:Image;
		override protected function createChildren():void
		{
			super.createChildren();
			if(!image)
			{
				image = new Image();
				image.source=icon;
				
				image.setActualSize(22,22);
				image.cacheAsBitmap=true;
				addChild(image);
				
			}
		}
		/**
		 * @private
		 * Boolean To Alert Us the There is a Text Change in our AutoSuggest 
		 */
		private var _promptTextChanged:Boolean;
    //--------------------------------------------------------------------------
    //
    // _usingAutoCompleteSuggest + getter/setter
    //
    //--------------------------------------------------------------------------
		/**
		 * @private
		 * The usingAutoCompleteSuggest will be used to show the word in the text prompt, 
		 * sort of like Completing the word with the closest suggestion
		 */
		private var _usingAutoCompleteSuggest:Boolean;
		/**
		 * @private
		 */
		 private var _autoCompleteSuggestChange:Boolean;
		/**
		 * @private
		 */
		public function get autoCompleteSuggest():Boolean
		{
			return _usingAutoCompleteSuggest;
		}
		/**
		 * @private
		 */
		public function set autoCompleteSuggest(value:Boolean):void
		{
			_usingAutoCompleteSuggest=value;
			_autoCompleteSuggestChange=true;
			invalidateProperties();
		
		}
		
   
    //--------------------------------------------------------------------------
    //
    // keyDownHandler
    //
    //--------------------------------------------------------------------------
		/**
		 * @private
		 * We just return the user to index = -1 if they go abover the 0 index
		 */
		 private var _usingBackSpace:Boolean=false;
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			//make sure it is not a ctrlKey, since that is used for something diffrent
			if(!event.ctrlKey)
			{
				//if the user is scrolling up with the keyboard and the selectedIndex is 0,
				//we bring them back to -1 which is where the prompt is
				if(event.keyCode == Keyboard.UP && selectedIndex==0)
				{
					selectedIndex=-1;
				}
				if(event.keyCode == Keyboard.BACKSPACE)
				{
					close();
					_usingBackSpace=true;
				}
				else
				{
					_usingBackSpace=false;
				}
												
			}
			super.keyDownHandler(event);
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			if(image)
			{
				image.x = unscaledWidth-image.measuredWidth-5 +15;
				image.y = unscaledHeight/2 - image.measuredHeight/2 +5;
				
			}
		}
    //--------------------------------------------------------------------------
    //
    // updateDataCollectionProvider
    //
    //--------------------------------------------------------------------------						
		/**
		 * @private
		 * The updateDataCollectionProvider, allows us to filter through the collection
		 * and determine what needs to be shown and what does not
		 */
		private function updateDataCollectionProvider():void
		{
			//prob bad assumption here that it will be one of the ICollectionView but 
			//that is the only class that does not filtering
			var tmpCollection:ICollectionView = dataProvider as ICollectionView;
			tmpCollection.filterFunction = _filterFunction;
			//don't forget to refresh
			tmpCollection.refresh();
			
		}
		
    //--------------------------------------------------------------------------
    //
    //  collectionChangeHandler
    //
    //--------------------------------------------------------------------------
		/**
		 * @private
		 * We override the collectionChangeHandler since every time there 
		 * is a change in the collection, this gets dispatch and when that happens
		 * we know that the user is searching so we open the dropdown
		 * menu
		 */
		override protected function collectionChangeHandler(event:Event):void
		{
			super.collectionChangeHandler(event);
			//if there is data then we open the dropdown
			if(dataProvider.length>0)
			{
				open();
			}
		}
    //--------------------------------------------------------------------------
    //
    //  getStyle
    //
    //--------------------------------------------------------------------------
		/**
		 * @private
		 * In This we check if the style used is openDuration or not,
		 * if it is we return 0. The reason we do this is because
		 * the dropdown menu gets a bit to jumpy and erratic if if we start
		 * backspacing really fast or typing too fast so this set the open duration
		 * to 0 so it opens, still there is a bit of jittery but not as much
		 */
		override public function getStyle(styleProp:String):*
		{
			if(styleProp !="openDuration")
			{
				return super.getStyle(styleProp);
			}
			else
			{
				if(!dropdown.visible)
				{
					return super.getStyle(styleProp);
				}
				else
				{
					return 0;
				}
			}
		}
    //--------------------------------------------------------------------------
    //
    //  myFilterFunction
    //
    //--------------------------------------------------------------------------		
		/**
		 * @private
		 * The Function that filters, what we do in this is we check
		 */
		private function myFilterFunction(item:Object):Boolean
		{
			var myLabel:String = itemToLabel(item);
			//so we check to see if the text in the prompt(user typing) is the same as the label which is the
			//dataProvider items, and if it is it means we add it to the list
			if(myLabel.substr(0,text.length).toLowerCase() == prompt.toLowerCase())
			{
				return true;
			}
			//other wise we don not
			return false;
		}
    	
    	private var $typedText:String;
    	protected function get typedText():String
    	{
    		return $typedText;
    	}
    	protected function set typedText(value:String):void
    	{
    		$typedText=value;
    	}
    //--------------------------------------------------------------------------
    //
    //  textInput_changeHandler
    //
    //--------------------------------------------------------------------------
		/**
		 * @private
		 * This Function gets called everytime there is a change in the prompt area
		 * which has a selected index of -1, so what we do is we update
		 * that there is a change in the text and call the commitProperties to
		 * take care of it
		 */
		override protected function textInput_changeHandler(event:Event):void
		{
						
			if(!_usingAutoCompleteSuggest)
			{
				_promptTextChanged=true;
			}
			else
			{
				_autoCompleteSuggestChange=true;
			}
			
			//make sure there is no empty field, otherwise it will
			//have all the suggestions open
			if(textInput.text == "")
			{
				close();
				//set it to false then since a "" means nothing changed
				//according to us
				_promptTextChanged=false;
				_autoCompleteSuggestChange=false;
			}
			$typedText = text;
			super.textInput_changeHandler(event);
			
			invalidateProperties();
		}
    //--------------------------------------------------------------------------
    //
    // commitProperties
    //
    //--------------------------------------------------------------------------
		/**
		 * @private
		 * Commit Properties takes care if there is a change in the prompt
		 * and updates the dataProvider
		 */
		override protected function commitProperties():void
		{
		  if(_promptTextChanged && !_usingAutoCompleteSuggest)
			{
				prompt=text;
				
				updateDataCollectionProvider();
				//must do this otherwise the text get reset
				textInput.setSelection(textInput.selectionEndIndex,textInput.selectionEndIndex);
				_promptTextChanged=false;
			}
			if(_autoCompleteSuggestChange && _usingAutoCompleteSuggest && textInput.text !="" && !_usingBackSpace)
			{
				prompt=text;
				
				var closestMatch:String="";
				updateDataCollectionProvider();
				if(dataProvider.length>0)
				{
					closestMatch=itemToLabel(dataProvider[0]);
										
				}
				var index:Number = closestMatch.toLowerCase().indexOf(prompt.toLowerCase());
				if(index==0)
				{
					var textToDisplay:String = prompt + closestMatch.substr(prompt.length);
					textInput.setSelection(prompt.length,textToDisplay.length);
					prompt = textToDisplay;
					
				}
				else
				{
					textInput.text=prompt;
					textInput.setSelection(textInput.selectionEndIndex,textInput.selectionEndIndex);
				}
							
				_autoCompleteSuggestChange=false;
					
			}
				
			//call it at the end or we get weird behavior, where we can't type more than
			//one letter
			super.commitProperties();
			
					
		}
    //--------------------------------------------------------------------------
    //
    //  measure
    //
    //--------------------------------------------------------------------------
		/**
		 * @private
		 * Overriding the measure, we set the measuredWidth to the Default which is 160,
		 * reason is to make the whole AutoSuggest look uniform next to others
		 */
		override protected function measure():void
		{
			super.measure();
			measuredWidth=UIComponent.DEFAULT_MEASURED_WIDTH;
			
		}
    //--------------------------------------------------------------------------
    //
    //  editable
    //
    //--------------------------------------------------------------------------
		/**
		 * @private
		 * Prevents any one from reseting this to being editable
		 */
		override public function set editable(value:Boolean):void
		{
			super.editable=true;
			
		}
    //--------------------------------------------------------------------------
    //
    //  filterFunction
    //
    //--------------------------------------------------------------------------
		/**
		 * @private
		 * Allows Us to set a custom Filter if the Developer
		 * does not want to use the one that comes with this
		 * component
		 */
		 private var _filterFunction:Function = myFilterFunction;
		 /**
		 * @private
		 */
		 public function get filterFunction():Function
		 {
		 	return _filterFunction;
		 }
		 /**
		 * @private
		 */
		 public function set filterFunction(value:Function):void
		 {
		 	if(value!=null)
		 	{
		 		_filterFunction=value;
		 	}
		 	else
		 	{
		 		_filterFunction=myFilterFunction;
		 	}
		 	
		 }
		
	}
}