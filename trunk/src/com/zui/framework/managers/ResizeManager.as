package com.zui.framework.managers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;

	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-8-27 下午05:57:29
	 * 
	 */
	public class ResizeManager
	{
		//======================================================================
		//        property
		//======================================================================
		private static var instance:ResizeManager;
		private var dic:Dictionary = new Dictionary;
		
		public  var enabled:Boolean = true;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function ResizeManager()
		{
			LayerManager.getInstance().stage.addEventListener(Event.RESIZE,onResize);
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public  function addHandler(func:Function):void{
			dic[func] = func;
			setTimeout(onResize,0,null);
		}
		
		
		
		public  function removeHandler(func:Function):void{
			delete dic[func];
		}
		
		public function setMiddle(obj:DisplayObject):void{
			obj.x = (LayerManager.getInstance().stage.stageWidth - obj.width)/2;
			obj.y = (LayerManager.getInstance().stage.stageHeight - obj.height)/2;
		}
		
		public function setTopLeft(obj:DisplayObject):void{
			obj.x = 0;
			obj.y = 0;
		}
		
		public function setTopRight(obj:DisplayObject):void{
			obj.x = (LayerManager.getInstance().stage.stageWidth - obj.width);
			obj.y = 0;
		}
		
		public function setTopMiddle(obj:DisplayObject):void{
			obj.x = (LayerManager.getInstance().stage.stageWidth - obj.width)/2;
			obj.y = 0;
		}
		
		public function setXY(obj:DisplayObject,$x:int,$y:int):void{
			obj.x = $x;
			obj.y = $y;
		}
		

		//======================================================================
		//        private function
		//======================================================================
		private function onResize(event:Event):void{
			if(enabled){
				for each(var func:Function in dic){
					func();
				}
			}
	
		}
		//======================================================================
		//        event handler
		//======================================================================
		public static function getInstance():ResizeManager{
			return instance ||= new ResizeManager();
		}
		//======================================================================
		//        getter&setter
		//======================================================================
		
		
	}
} 