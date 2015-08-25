package com.zui.framework.components
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import com.zui.framework.interfaces.IDispose;
	
	public class ZViewStack extends Sprite implements IDispose
	{
		
		private var itemList:Array = [];
		
		public function ZViewStack(itemList:Array)
		{
			this.itemList = itemList;
			for(var i:int = 0; i<itemList.length; i++){
				addChild(itemList[i]);
			}
		}
		
		public function dispose():void{
			itemList = [];
		}
		
		public function setSelectIndex(index:int):void{
			for(var i:int = 0 ; i<itemList.length; i++){
				if(i!=index){
					itemList[i].visible = false;
				}else{
					itemList[i].visible = true;
				}	
			}
		}

		
		
		
	}
}