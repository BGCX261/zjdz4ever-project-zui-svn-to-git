package com.zui.framework.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import com.zui.framework.components.classes.ListItemVO;
	import com.zui.framework.events.ZEvent;
	import com.zui.framework.utils.ASFont;
	
	public class ZComboBox extends Sprite
	{
		private var list:ZList;
		private var skinBt:ZMcButton;
		private var arrowBt:Sprite;
		public var selectedItem:ListItemVO;
		private var label:ZLabel;
		private var defaultSelectIndex:int = 0;
		/**
		 * 尚未扩展scrollbar部分 有需求再扩展，感觉加入了scrollbar界面会略显复杂
		 * 
		 * @param comboSkin				combobox皮肤
		 * @param comboArrowSkin		combobox上面箭头的皮肤
		 * @param listItemClass			combobox下面list单个块的皮肤
		 * @param defaultItemHeight		默认单个块的高度
		 * @param defaultSelectIndex	默认选中的index
		 * 
		 */		
		public function ZComboBox(comboSkin:Class,comboArrowSkin:Class,listItemClass:Class,defaultItemHeight:int = 25,defaultSelectIndex:int = 0)
		{
			super();
			this.defaultSelectIndex = defaultSelectIndex;
			skinBt = new ZMcButton();
			skinBt.setSkin(new comboSkin());
			addChild(skinBt.getSkin());
			list = new ZList(listItemClass,defaultItemHeight);
			list.addEventListener(ZEvent.SELECTED_CHANGE,onSelectedChange);
			skinBt.addActionEventListener(onClick);
			list.visible = false;
			addChild(list);
			list.y = skinBt.height;
			arrowBt = new comboArrowSkin() as Sprite;
			skinBt.getSkin().addChild(arrowBt);
			arrowBt.x = skinBt.width - arrowBt.width - 3;	
			arrowBt.y = (skinBt.height - arrowBt.height)/2;
			label = new ZLabel();
			
			label.mouseEnabled = false;
			label.setSizeWH(skinBt.width -  arrowBt.width - 5,skinBt.height);
			addChild(label);
			label.setFont("Microsoft YaHei",14);

			
		}
		
		public function dispose():void
		{
			stage.removeEventListener(MouseEvent.CLICK,onClickStage);
			skinBt.removeActionEventListener();
			list.removeEventListener(ZEvent.SELECTED_CHANGE,onSelectedChange);
			list.dispose();
		}
		
		private function onClick():void
		{
			
			if(list.visible){
				list.visible = false;
			}else{
				list.visible = true;
				stage.addEventListener(MouseEvent.CLICK,onClickStage);
			}
			
		}
		
		public function update():void
		{
			list.update();
		}
		
		public function addItem(vo:ListItemVO):void
		{
			list.addItem(vo);
		}
		
		public function removeAll():void
		{
			list.removeAll();
		}
		
		public function addItemAt(vo:ListItemVO,index:int):void
		{
			list.addItemAt(vo,index);
		}
		
		public function get dataProvider():Vector.<ListItemVO>
		{
			return list.dataProvider;
		}
		
		public function setComboFont(font:String = "Tahoma", size:Number = 12, color:uint = 0x0, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false, align:String = "center") : void
		{
			label.setFont(font, size, color, bold, italic, underline, align);
		}
		
		public function setItemFont(font:String = "Tahoma", size:Number = 12, color:uint = 0x0, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false, align:String = "center") : void{
			list.setItemFont(font, size, color, bold, italic, underline, align);
		}
			
		public function set dataProvider(value:Vector.<ListItemVO>):void
		{
			list.dataProvider = value;
			setSelectIndex(defaultSelectIndex);
			
		}
		
		private function onSelectedChange(event:ZEvent):void{
			selectedItem = list.getVoByIndex(event.data as int);
			label.setText(selectedItem.label);
		}
		
		private function onClickStage(event:MouseEvent):void{
			if(event.target!=skinBt.getSkin()){
				stage.removeEventListener(MouseEvent.CLICK,onClickStage);
				onClick();
			}
		
		}
		
		/**
		 *  外部设置选中的index 
		 * @param arg
		 * 
		 */		
		public function setSelectIndex(arg:int):void{
			if(dataProvider){
				selectedItem = list.getVoByIndex(arg);
				list.setSelectIndex(arg);
				label.setText(selectedItem.label);	
			}
	
		}
	
		
		
		
		
	}
}