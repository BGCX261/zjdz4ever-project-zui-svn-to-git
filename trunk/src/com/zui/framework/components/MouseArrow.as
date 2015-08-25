package com.zui.framework.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.ui.Mouse;
	import com.zui.framework.managers.DataManager;

	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-7-26 下午05:24:15
	 * 
	 * 鼠标指针，用其他替代原有指针
	 */
	public class MouseArrow
	{
		//======================================================================
		//        property
		//======================================================================
		private var mouseObj:Object;
		private static var _instance:MouseArrow;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function MouseArrow()
		{
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public function addArrow(displayObject:Object):void{
			Mouse.hide();
			if(mouseObj == null){
				mouseObj = displayObject;
				DataManager.getInstance().effectLayer.addChild(displayObject);
				displayObject.mouseChildren = false;
				displayObject.mouseEnabled = false;
				displayObject.visible = false;
				DataManager.getInstance().effectLayer.addChild(displayObject);
				DataManager.getInstance().root.addEventListener(Event.ENTER_FRAME,ef);
			}
		}

		
		public  function removeArrow(callback:Function = null):void{
			DataManager.getInstance().root.removeEventListener(Event.ENTER_FRAME,ef);
			Mouse.show();
			if(mouseObj){
				if(DataManager.getInstance().effectLayer.contains(mouseObj)==true){
					DataManager.getInstance().effectLayer.removeChild(mouseObj);
					if(callback!=null){
						callback(mouseObj);
					}
					mouseObj = null;
					
				}
				
			}
		}

		public static function get instance():MouseArrow
		{
			if(_instance = null){
				_instance = new MouseArrow();
			}
			return _instance;
		}



		//======================================================================
		//        private function
		//======================================================================
		
		//======================================================================
		//        event handler
		//======================================================================
		
		private  function ef(event:Event):void{
			mouseObj.x = DataManager.getInstance().root.stage.mouseX - mouseObj.width/2;
			mouseObj.y = DataManager.getInstance().root.stage.mouseY - mouseObj.height/2;
			mouseObj.visible = true;
		}
		//======================================================================
		//        getter&setter
		//======================================================================
		
		
	}
} 