package com.zui.framework.components
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ZTextArea extends TextField
	{
		public function ZTextArea()
		{
			super();
			multiline = true;
			wordWrap = true;
			autoSize = TextFieldAutoSize.NONE;
			background = false;
		}
		
		public function setLocationXY($x:int, $y:int) : void
		{
			this.x = $x;
			this.y = $y;
		}
		
		public function setSizeWH($width:uint, $height:uint) : void
		{
			this.width = $width;
			this.height = $height;
		}
		
		public function appendTxt(str:String) : void
		{
			this.replaceText(this.length, this.length, str);
		}
		
		public function appendTextWith(str:String, tf:TextFormat) : void
		{
			if (str != null)
			{
				this.appendTxt(str);
				if (tf != null)
				{
					this.setTextFormat(tf, this.length - str.length, this.length);
				}
			}
		}

	}
}