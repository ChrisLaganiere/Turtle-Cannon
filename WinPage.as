package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode
		Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT; 
	
	public class WinPage extends MovieClip
	{
		var comingUp:int = Main.lastLevel + 1;
		
		public function StartPage()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:Event):void
		{
			trace("WinPage added to stage...");
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//personal Event Listeners
			this.startButton.addEventListener(TouchEvent.TOUCH_TAP,startPress);
			this.startButton.addEventListener(MouseEvent.CLICK, clickPress);
			
			levelText.text = "Part " + String(Main.lastLevel);
		}
		private function onRemovedFromStage(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.startButton.removeEventListener(TouchEvent.TOUCH_TAP,startPress);
			this.startButton.removeEventListener(MouseEvent.CLICK, clickPress);
		}
		private function startPress(event:TouchEvent):void
		{
			Main.nextLevel = comingUp;
			Main.endLevel = true;
			Main.startLevel = true;
		}
		private function clickPress(event:MouseEvent):void
		{
			Main.nextLevel = comingUp;
			Main.endLevel = true;
			Main.startLevel = true;
		}
		public function frameActions():void
		{
			
		}
	}
}