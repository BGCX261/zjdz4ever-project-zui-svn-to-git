package com.zui.framework.components
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import com.zui.framework.utils.ASFont;
	
	public class ZLabel extends TextField
	{
		private var font:ASFont;

		
		public function ZLabel(text:String = "")
		{
			super();
			multiline = true;
			autoSize = TextFieldAutoSize.NONE;
			background = false;
			this.text = text;
		}
		
		public function setText(text:String) : void
		{
			if (this.text != text)
			{
				this.text = text;
			}
			this.repaint();
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
		

		
		public function repaint() : void
		{
			if (this.visible && this.font != null)
			{
				this.setTextFormat(this.font.getTextFormat());
			}
		}
		
		

		
		public function setFont(font:String = "Tahoma", size:Number = 12, color:uint = 0x0, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false, align:String = "center") : ASFont
		{
			this.font = new ASFont(font, size,color, bold, italic, underline, align);
			this.font.apply(this);
			return this.font;
		}

	}
}