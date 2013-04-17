﻿package{	import flash.display.MovieClip;	import flash.events.Event;		public class Cannon extends MovieClip	{		public function Cannon()		{			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		}		private function onAddedToStage(event:Event):void		{			addEventListener(Event.ENTER_FRAME, onEnterFrame);			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);		}		private function onRemovedFromStage(event:Event):void		{			removeEventListener(Event.ENTER_FRAME, onEnterFrame);			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);		}		private function onEnterFrame(event:Event):void		{			MovieClip(parent).frameChildren.push(this);		}		public function frameActions():void		{			if (Collision.checkVisible(this))			{				if (this.hitTestObject(MovieClip(parent).player))				{					Collision.cannonBlock(MovieClip(parent).player, this);				}			}		}	}}