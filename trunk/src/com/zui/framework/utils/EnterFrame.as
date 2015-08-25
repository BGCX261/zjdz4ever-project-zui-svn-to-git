package com.zui.framework.utils
{
	import flash.display.InteractiveObject;
	import flash.events.Event;

	public class EnterFrame
	{
		private static var _funcQueue:Array;
		private static var _i:int = 0;
		private static var isPause:Boolean = false;
		
		public function EnterFrame()
		{
		}
		/**
		 *	初始化函数 
		 * @param obj
		 * 
		 */		
		public static function set linstener(obj:InteractiveObject) : void{
			var linstener:InteractiveObject = obj;
			_funcQueue = [];
			
			
			linstener.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			
		}
		/**
		 *	插入enterframe函数 
		 * @param func
		 * 
		 */		
		public static function pushFunc(func:Function) : void
		{
			if (indexOfFunc(func) == -1)
			{
				_funcQueue.push(func);
			}
			return;
		}
		
		/**
		 * 暂停 
		 * @param value
		 * 
		 */	
		public static function set pause(value:Boolean) : void
		{
			isPause = value;
			return;
		}
		
		public static function popFunc(func:Function) : void
		{
			var tmpIndex:int = indexOfFunc(func);
			if (tmpIndex != -1)
			{
				_funcQueue.splice(tmpIndex, 1);
				if (tmpIndex <= _i)
				{
					_i--;
					if (_i < 0)
					{
						_i = 0;
					}
				}
			}
			
		}
		
		private static function onEnterFrame(event:Event):void{
			if (!isPause)
			{
				while (_i < _funcQueue.length)
				{
					_funcQueue[_i]();
					
					_i++;
				}
				_i = 0;
			}
			
		}
		
		private  static function indexOfFunc(param1:Function) : int
		{
			return _funcQueue.indexOf(param1);
		}
		
		
	
	}
}