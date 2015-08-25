package com.zui.framework.components.classes
{
	import com.zui.framework.components.ZTabButton;
	import com.zui.framework.events.ZEvent;
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-9-25 下午04:17:30
	 * 
	 */
	public class TabControl extends EventDispatcher
	{
		//======================================================================
		//        property
		//======================================================================
		private var selectedIndex:int = -1;
		private var items:Vector.<ZTabButton>;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function TabControl()
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
						items[i].skin.removeEventListener(MouseEvent.CLICK,onClickHandler);
					}
				}
			}
		}
		
		public function setSelectIndex(arg:int):int{
			if(selectedIndex!=arg){
				for(var i:int = 0; i<items.length; i++){
					
						items[i].selected = false;
					
				}
				selectedIndex = arg;
				items[arg].selected = true;
				
			}
			return selectedIndex;
		}
		
		public function getSelectedIndex():int{
			return selectedIndex;
		}
		
		
		public function setItems(ary:Vector.<ZTabButton>):void{
			clear();
			this.items = ary;
			for(var i:int = 0 ; i<ary.length; i++){
				
				ary[i].skin.addEventListener(MouseEvent.CLICK,onClickHandler);
				if(selectedIndex == i){
					ary[i].selected = true;
				}else{
					ary[i].selected = false;
				}
			}
		}
		
		private function onClickHandler(event:MouseEvent):void{
			for(var i:int = 0; i<items.length; i++){
				if(items[i].selected){
					items[i].selected = false;
				}			
			}
			for(i = 0; i<items.length; i++){
				if(items[i].skin == event.currentTarget as DisplayObject){
					selectedIndex = i;
					items[i].selected = true;
					dispatchEvent(new ZEvent(ZEvent.SELECTED_CHANGE,selectedIndex));
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