package com.zui.framework.components
{
	import com.zui.framework.events.ZEvent;
	import com.zui.framework.interfaces.ISelect;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	public class ZItemSelectControl extends EventDispatcher
	{

		private var selectedIndex:int = -1;
		private var items:Array;
		
		public function ZItemSelectControl()
		{
			
		}
		
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
		
		public function setSelectIndex(arg:int):int{
			if(selectedIndex!=arg){
				for(var i:int = 0; i<items.length; i++){
					if((items[i] as ISelect).selected){
						(items[i] as ISelect).selected = false;
					}
				}
				selectedIndex = arg;
				(items[arg] as ISelect).selected = true;
				
			}
			return selectedIndex;
		}
		
		public function getSelectedIndex():int{
			return selectedIndex;
		}
		
		
		public function setItems(ary:Array):void{
			clear();
			this.items = ary;
			for(var i:int = 0 ; i<ary.length; i++){
				var tmpItem:Object = ary[i];
				tmpItem.addEventListener(MouseEvent.CLICK,onClickHandler);
				if(selectedIndex == i){
					tmpItem.selected = true;
				}else{
					tmpItem.selected = false;
				}
			}
		}
		
		private function onClickHandler(event:MouseEvent):void{
			for(var i:int = 0; i<items.length; i++){
				if((items[i] as ISelect).selected){
					(items[i] as ISelect).selected = false;
				}			
			}
			selectedIndex = items.indexOf(event.currentTarget as DisplayObject);
			(event.currentTarget as ISelect).selected = true;
			dispatchEvent(new ZEvent(ZEvent.SELECTED_CHANGE,selectedIndex));
			
		}
		


	}
}