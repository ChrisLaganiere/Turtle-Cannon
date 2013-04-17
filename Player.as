﻿package{	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.KeyboardEvent;	import flash.ui.Keyboard;	import flash.events.TouchEvent;	import flash.ui.Multitouch;	import flash.ui.MultitouchInputMode	Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT; 	import flash.sensors.Accelerometer;	import flash.events.AccelerometerEvent;		public class Player extends MovieClip	{		public var gravityAccel:int = 2;		public var gravityCap:int = 30;		public var boostAccel:int = 40;		public var _vx:Number = 0;		public var _vx2:Number = 0; //for keyboard movement		public var _vy:Number = 0;		public var canJump:Boolean = false;		public var gravity:Boolean = true;		public var canWin:Boolean = false;				private var accelX:Number;		var fl_Accelerometer:Accelerometer = new Accelerometer();				public function Player()		{			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		}				private function onAddedToStage(event:Event):void		{			addEventListener(Event.ENTER_FRAME, onEnterFrame);			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			//keyboard event listeners			stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchStart);			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);			//accelerometer event listener			fl_Accelerometer.addEventListener(AccelerometerEvent.UPDATE, fl_AccelerometerUpdateHandler);		}		private function onRemovedFromStage(event:Event):void		{			removeEventListener(Event.ENTER_FRAME, onEnterFrame);			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage)			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);			fl_Accelerometer.removeEventListener(AccelerometerEvent.UPDATE, fl_AccelerometerUpdateHandler);			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		}		function fl_AccelerometerUpdateHandler(event:AccelerometerEvent):void		{			accelX = event.accelerationX;		}		public function frameActions():void		{			if (gravity)			{				_vy += gravityAccel;				if (_vy > gravityCap)				{					_vy = gravityCap;				}				if (_vx > gravityCap)				{					_vx = gravityCap;				}			}			if (!isNaN(accelX))			{				//Prevent Not a Number error				this.x -= 60*accelX;			}			this.x += _vx + _vx2;			this.y += _vy;			if (_vx > 0)			{				//Bring velocity to zero				_vx--;			}			else if (_vx < 0)			{				//Bring velocity to zero				_vx++			}			boundaries();		}		private function boundaries():void		{			if (this.y > MovieClip(parent).myHeight - this.height/2)			{				this.y = MovieClip(parent).myHeight - this.height/2;				_vy = -boostAccel;			}			if (this.x > Main.stageW + this.width/2)			{				this.x = 0 - this.width/2;			}			else if (this.x < 0 - this.width/2)			{				this.x = Main.stageW + this.width/2;			}		}		private function onTouchStart(event:TouchEvent):void		{			if(canJump)			{				_vy = -boostAccel;				canJump = false;				gravity = true;			}		}		private function onKeyDown(event:KeyboardEvent):void		{			if (event.keyCode == Keyboard.LEFT)			{				this._vx2 = -30;			}			else if (event.keyCode == Keyboard.RIGHT)			{				this._vx2 = 30;			}			else if (event.keyCode == Keyboard.SPACE)			{				if(canJump)				{					_vy = -boostAccel;					canJump = false;					gravity = true;				}			}		}		private function onKeyUp(event:KeyboardEvent):void		{			if (event.keyCode == Keyboard.LEFT)			{				if (_vx2 < 0)				{					this._vx2 = 0;				}			}			else if (event.keyCode == Keyboard.RIGHT)			{				if (_vx2 > 0)				{					this._vx2 = 0;				}			}		}		private function onEnterFrame(event:Event):void		{			//My frame actions manually run first to prevent visual errors			//MovieClip(parent).frameChildren.push(this);		}	}}