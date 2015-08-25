package com.zui.framework.components.classes
{
	import com.zui.framework.components.ZMcButton;
	import com.zui.framework.events.ZEvent;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.sensors.Accelerometer;

	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-9-26 下午01:47:11
	 * 
	 * zmcButton控制类
	 */
	public class ButtonsControl extends EventDispatcher
	{
		//======================================================================
		//        property
		//======================================================================
		private var items:Array = [];
		
		//======================================================================
		//        constructor
		//======================================================================
		
		public function ButtonsControl()
		{
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public function dispose():void{
			clear();
		}
		
		private function clear():void{
			if(items){
				if(items.length>0){
					for(var i:int = 0 ; i<items.length; i++){
						items[i].removeEventListener(MouseEvent.CLICK,onClickHandler);
					}
				}
			}
		}

		
		
		public function setItems(ary:Array):void{
			clear();
			this.items = ary;
			for(var i:int = 0 ; i<ary.length; i++){
				var tmp:ZMcButton = new ZMcButton();
				tmp.setSkin(ary[i] as MovieClip);
				ary[i].addEventListener(MouseEvent.CLICK,onClickHandler);
				
			}
		}
		
		private function onClickHandler(event:MouseEvent):void{
			for(var i:int = 0; i<items.length; i++){
				if(items[i] == event.currentTarget as DisplayObject){
					dispatchEvent(new ZEvent(ZEvent.SELECTED_CHANGE,i));
				}
			}
			
			
			
		}
		//======================================================================
		//        private function
		//======================================================================
		
		//======================================================================
		//        event handler
		//======================================================================
		
		//======================================================================
		//        getter&setter
		//======================================================================
		
		
	}
} 