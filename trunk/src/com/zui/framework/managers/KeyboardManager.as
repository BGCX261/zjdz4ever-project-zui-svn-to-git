package com.zui.framework.managers
{
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;

	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-8-27 上午10:38:14
	 * 
	 */
	public class KeyboardManager
	{
		//======================================================================
		//        property
		//======================================================================
		private static var instance:KeyboardManager;
		private var keyDic:Dictionary = new Dictionary;
		private var _enabled:Boolean = true;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function KeyboardManager()
		{
			LayerManager.getInstance().stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			LayerManager.getInstance().stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public function registerKey(keyCode:uint,func:Function):void{
			keyDic[keyCode] = func;
		}
		
		public function removeKey(keyCode:uint):void{
			if(keyDic[keyCode]){
				delete keyDic[keyCode];
			}
		
		}
		
		public function set enabled(bool:Boolean):void{
			_enabled = bool;
		}
		//======================================================================
		//        private function
		//======================================================================
		
		//======================================================================
		//        event handler
		//======================================================================
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if(_enabled){
				if(keyDic[event.keyCode]!=null){
					if(!(LayerManager.getInstance().stage.focus is TextField) || event.keyCode == Keyboard.ENTER){
						keyDic[event.keyCode]();
					}
					
				}
			}
			LayerManager.getInstance().stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			if(LayerManager.getInstance().stage.hasEventListener(KeyboardEvent.KEY_DOWN) == false){
				setTimeout(function():void{LayerManager.getInstance().stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown)},0);
			}
			
		}
		
		//======================================================================
		//        getter&setter
		//======================================================================
		public static function getInstance():KeyboardManager{
			return instance ||=new KeyboardManager();
		}
		
	}
} 