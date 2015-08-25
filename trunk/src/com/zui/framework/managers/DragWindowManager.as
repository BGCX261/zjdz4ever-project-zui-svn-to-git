package com.zui.framework.managers
{
	import com.zui.framework.utils.HashMap;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;

	/**
	 * @version 1.0.0
	 * creation time：2012-9-20 下午02:18:26
	 * 
	 */
	public class DragWindowManager
	{
		//======================================================================
		//        const variable
		//======================================================================
		private static var _instance:DragWindowManager;
		//======================================================================
		//        static variable
		//======================================================================
		
		//======================================================================
		//        variable
		//======================================================================
		private var _window:DisplayObjectContainer;
		private var _objs:Array;
		private var _windows:Dictionary;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function DragWindowManager()
		{
			_windows=new Dictionary();
			_objs=[];
		}
		
		
		
		//======================================================================
		//        function
		//======================================================================
		public static function getInstance():DragWindowManager
		{
			if(_instance==null)
			{
				_instance=new DragWindowManager();
			}
			return _instance;
		}
		/**
		 * 注册一个窗口，单个拖拽点
		 * @param window
		 * @param dragTarget
		 * 
		 */			
		public function registerSingle(window:DisplayObjectContainer,dragTarget:DisplayObject):void
		{
			if(window != null && dragTarget!= null)
			{
				_window=window;
				_windows[dragTarget]=_window;
				_objs.push(dragTarget);
				addListener([dragTarget]);
			}
		}
		
		public function registerDragTargets(window:DisplayObjectContainer,dragTargets:Array):void
		{
			if(window != null &&dragTargets.length!=0)
			{
				_window=window;
				for(var i:int=0;i<dragTargets.length;i++)
				{
					var tmp:MovieClip=dragTargets[i];
					_windows[dragTargets[i]]=_window;
					_objs.push(tmp);
				}
				addListener(dragTargets)
			}
		}
		
		public function dispose():void
		{
			for(var i:int=0;i<_objs.length;i++)
			{
				_objs[i].removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			}
			_windows=new Dictionary();
		}

		//======================================================================
		//        private function
		//======================================================================
		
		//======================================================================
		//        event handler
		//======================================================================
		private function addListener(dragTargets:Array):void
		{
			for(var i:int=0;i<dragTargets.length;i++)
			{
				var tmp:MovieClip=dragTargets[i];
				_objs.push(tmp);
				tmp.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			}
		}
		private function onMouseDown(e:MouseEvent):void
		{
			(_window as Sprite).startDrag();
			for(var i:int=0;i<_objs.length;i++)
			{
				_objs[i].addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}
		}
		private function onMouseUp(e:MouseEvent):void
		{
			(_window as Sprite).stopDrag();
			for(var i:int=0;i<_objs.length;i++)
			{
				_objs[i].removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}
			
		}
		
		//======================================================================
		//        getter&setter
		//======================================================================
		
		
	}
} 