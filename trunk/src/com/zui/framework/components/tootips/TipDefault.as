package com.zui.framework.components.tootips
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import com.zui.framework.components.ZLabel;
	import com.zui.framework.components.ZTextArea;
	import com.zui.framework.interfaces.ITip;
	import com.zui.framework.utils.HtmlTextUtils;
	
	public class TipDefault extends Sprite implements ITip
	{
		public function TipDefault()
		{
			super();
			
		}
		
		public function setTipString(str:String):void
		{
			var t:TextField = new TextField();
			t.multiline = true;
			t.wordWrap = false;
			
			t.htmlText = str;
			t.width = t.textWidth+5;
			addChild(t);
			if(t.width>200){
				t.width = 200; 
				t.wordWrap = true;
			}
			t.height = t.textHeight+6;
//			t.autoSize = TextFieldAutoSize.LEFT;
			this.graphics.beginFill(0);
			this.graphics.drawRoundRect(0,0,t.width+10,t.height+6,5);
			this.graphics.endFill();
			t.y = 3;
			t.x = 5;
			
		}
		
		public function getTipString():void
		{
		}
		
		public function getDisplayObject():DisplayObject
		{
			return null;
		}
		
		public function setDisplayObject(obj:DisplayObject):void
		{
		}
		
		public function dispose():void
		{
			this.graphics.clear();
		}
	}
}