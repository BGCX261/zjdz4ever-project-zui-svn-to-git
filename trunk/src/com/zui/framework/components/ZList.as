package com.zui.framework.components
{
	import com.zui.framework.components.classes.ListItem;
	import com.zui.framework.components.classes.ListItemVO;
	import com.zui.framework.events.ZEvent;
	import com.zui.framework.utils.ASFont;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class ZList extends Sprite
	{
		public var defaultItemHeight:Number=25;
		private var itemsSprite:Sprite;
		private var itemAry:Array = [];
		private var scroll:ZScrollBar;
		private var _dataProvider:Vector.<ListItemVO>;
		private var skin:Class;
		private var itemSelectControl:ZItemSelectControl;
		private var asFont:ASFont;
		
		public function ZList(listItemSkin:Class,defaultItemHeight:int = 25)
		{
			super();
			this.defaultItemHeight = defaultItemHeight;
			itemsSprite = new Sprite();
			addChild(itemsSprite);
			skin = listItemSkin;
			itemSelectControl = new ZItemSelectControl();
			itemSelectControl.addEventListener(ZEvent.SELECTED_CHANGE,onSelectedChange);
			
		}
		
		public function dispose():void{
			itemSelectControl.dispose();
			itemSelectControl = null;
			_dataProvider = null;
			skin = null;
			itemsSprite = null;
			itemAry = [];
		}
		
		public function setSelectIndex(arg:int):void{
			itemSelectControl.setSelectIndex(arg);
		}
		
		public function update():void{
			for(var i:int = 0; i<itemAry.length; i++){
				var tmpItem:ListItem = itemAry[i] as ListItem;
				tmpItem.y = defaultItemHeight*i;
				
			}
			
			itemSelectControl.setItems(itemAry);
		}
		
		public function addItem(vo:ListItemVO):void{
			addItemAt(vo,itemsSprite.numChildren);
		}
		
		public function getVoByIndex(index:int):ListItemVO{
			return (itemsSprite.getChildAt(index) as ListItem).listItemVO;
		}


		public function removeAll():void{
			for(var i:int = 0; i<itemAry.length; i++){
				if(itemAry[i]){
					if(itemAry[i].parent){
						itemAry[i].parent.removeChild(itemAry[i]);
						itemAry[i].dispose();
					}
				}
			}
			itemAry = [];
		}
		
		public function setItemFont(font:String = "Tahoma", size:Number = 12, color:uint = 0x0,bold:Boolean = false, italic:Boolean = false, underline:Boolean = false, align:String = "center") : void{
			asFont = new ASFont(font, size,color, bold, italic, underline, align);
		}
		
		public function addItemAt(vo:ListItemVO,index:int):void{
			var listItem:ListItem = new ListItem(new skin() as MovieClip);
			if(asFont){
				listItem.setFont(asFont.getTextFormat());
			}
			
			listItem.listItemVO = vo;
			index = (index>itemsSprite.numChildren)?itemsSprite.numChildren:index;
			itemsSprite.addChildAt(listItem,index);
			itemAry.splice(1,index,listItem);
			update();
		}

		public function get dataProvider():Vector.<ListItemVO>
		{
			return _dataProvider;
		}

		public function set dataProvider(value:Vector.<ListItemVO>):void
		{
			_dataProvider = value;
			removeAll();
			for(var i:int = 0; i<value.length; i++){
				var tmpVO:ListItemVO = value[i];
				addItem(tmpVO);
			}
		}
		
		private function onSelectedChange(event:ZEvent):void{
			dispatchEvent(new ZEvent(ZEvent.SELECTED_CHANGE,event.data));
		}
		
		


	}
}