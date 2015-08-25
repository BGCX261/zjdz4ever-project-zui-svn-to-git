package com.zui.framework.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	/**
	 * @version 1.0.0
	 * creation time：2012-9-20 上午10:33:27
	 * 
	 */
	public class WindowsManager
	{
		//======================================================================
		//        const variable
		//======================================================================
		private static var _instance:WindowsManager;
		public static const REMOVE:String="remove";
		public static const UNREMOVE:String="unremove";
		//======================================================================
		//        static variable
		//======================================================================
		
		//======================================================================
		//        variable
		//======================================================================
		private var _windows:Dictionary;
		private var _windowsContainer:DisplayObjectContainer;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function WindowsManager()
		{
			_windows=new Dictionary();
		}
		
		
		
		//======================================================================
		//        function
		//======================================================================
		public static function getInstance():WindowsManager
		{
			if(_instance==null)
			{
				_instance=new WindowsManager();
			}
			return _instance;
		}
		public function registerWindows(windows:DisplayObjectContainer):void
		{
			if(windows!=null)
			{
				_windowsContainer=windows;
			}
		}
		public function popUpAndCenter(window:DisplayObject):void
		{
			popUpWindow(window);
			centerWindow(window);
		}
		public function popUpWindow(window:DisplayObject):void
		{
			var exist:Boolean=false;
			if(window)
			{
				exist=_windows[window];
				if(exist)
				{
					removeWindow(window);
					
//					bringToTop(window);
				}
				else
				{
					_windows[window]=true;
					_windowsContainer.addChild(window);
					addListener(window);
				}
			}
		}
		public function centerWindow(window:DisplayObject):void
		{
			if(window)
			{
				ResizeManager.getInstance().setMiddle(window);
			}
		}
		public function bringToTop(window:DisplayObject):void
		{
			if(_windowsContainer.getChildAt(_windowsContainer.numChildren-1)!=window)
			{
				_windowsContainer.setChildIndex(window,_windowsContainer.numChildren-1);
			}
		}
		public function removeWindow(window:DisplayObject):void
		{
			if(window)
			{
				delete _windows[window];
				if(window && _windowsContainer.contains(window))
				{
					_windowsContainer.removeChild(window);
				}
				removeListener(window);
				LayerManager.getInstance().stage.focus=LayerManager.getInstance().stage;
			}
		}
		public function removeAllWindows():void
		{
			while(_windowsContainer.numChildren>0)
			{
				var window:DisplayObject=_windowsContainer.getChildAt(0);
				removeWindow(window);
				removeListener(window);
			}
			_windows=new Dictionary();
			LayerManager.getInstance().stage.focus=LayerManager.getInstance().stage;
			
		}
		//======================================================================
		//        private function
		//======================================================================
		private function addListener(window:DisplayObject):void
		{
			window.addEventListener(MouseEvent.CLICK,bringToTopHandler);
			
		}
		private function removeListener(window:DisplayObject):void
		{
			window.removeEventListener(MouseEvent.CLICK,bringToTopHandler);
			
		}
		private function bringToTopHandler(e:MouseEvent):void
		{
			bringToTop(e.currentTarget as DisplayObject);
		}
		//======================================================================
		//        event handler
		//======================================================================
		
		//======================================================================
		//        getter&setter
		//======================================================================
		
		
	}
} 