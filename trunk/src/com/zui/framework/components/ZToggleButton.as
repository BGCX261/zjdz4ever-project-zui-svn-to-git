package com.zui.framework.components
{
	import com.zui.framework.components.classes.TabControl;
	import com.zui.framework.events.ZEvent;
	import com.zui.framework.layout.ZLayout;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	public class ZToggleButton extends EventDispatcher
	{
		public var tabButtonList:Vector.<ZTabButton> = new Vector.<ZTabButton>;
		private var selectedContol:TabControl;
		private var zviewStack:ZViewStack;
		private var changeListener:Function;
		/**
		 * 
		 * @param skinList 可以传入class或者实例
		
		 * 
		 */		
		public function ZToggleButton(skinList:Array,defaultIndex:int = -1)
		{
			super();
			for(var i:int = 0; i<skinList.length; i++){
				var tabBt:ZTabButton;
				if((skinList[i] is ZTabButton)){
					tabBt = skinList[i];
				}else{
					tabBt = new ZTabButton(skinList[i]);
				}
				tabButtonList.push(tabBt);
				
			}			
			selectedContol = new TabControl();
			selectedContol.setItems(tabButtonList);
			selectedContol.addEventListener(ZEvent.SELECTED_CHANGE,onSelectedChange);
			selectedContol.setSelectIndex(defaultIndex);
		}
		
		public function setText(index:int,text:String):void{
			if(tabButtonList[index]){
				(tabButtonList[index] as ZTabButton).setText(text);
			}
		}
		
		public function addChangeListener(func:Function):void{
			changeListener = func;
		}
		
		public function removeChangeListener(func:Function):void{
			changeListener = null;
		}
		
		public function dispose():void{
			changeListener = null;
			tabButtonList.length = 0;
			selectedContol.dispose();
		}
		

		
		private function onSelectedChange(event:ZEvent):void{
			if(zviewStack){
				zviewStack.setSelectIndex(event.data as int);
			}
			if(this.changeListener!=null){
				changeListener(event.data as int);
			}
		}
		
		public function setViewStack(zviewStack:ZViewStack,selectedIndex:int = 0):void{
			this.zviewStack = zviewStack;
			zviewStack.setSelectIndex(selectedContol.setSelectIndex(selectedIndex));
		}
		
		public function getSelectIndex():int{
			return selectedContol.getSelectedIndex();
		}
		
		
	}
}