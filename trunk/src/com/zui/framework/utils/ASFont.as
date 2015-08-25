package com.zui.framework.utils
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.zui.framework.geom.IntDimension;

	public class ASFont
	{
		private var name:String;
		private var size:uint;
		private var bold:Boolean;
		private var italic:Boolean;
		private var underline:Boolean;
		private var align:String;
		private var textFormat:TextFormat;
		private var color:uint;
		
		public function ASFont(name:String = "Tahoma", size:Number = 11,color:uint = 0x0, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false, align:String = "left")
		{
			this.name = name;
			this.size = size;
			this.bold = bold;
			this.italic = italic;
			this.underline = underline;
			this.align = align;
			this.color = color;
			this.textFormat = this.getTextFormat();
		}
		
		
		public function getName() : String
		{
			return this.name;
		}

		
		public function changeName(name:String) : ASFont
		{
			return new ASFont(name, this.size, this.color,this.bold, this.italic, this.underline, this.align);
		}
		
		public function changeSize(size:int) : ASFont
		{
			return new ASFont(this.name, size, this.color,this.bold, this.italic, this.underline, this.align);
		}
		
		public function isBold() : Boolean
		{
			return this.bold;
		}
		
		public function changeBold(bold:Boolean) : ASFont
		{
			return new ASFont(this.name, this.size,this.color, bold, this.italic, this.underline, this.align);
		}
		
		public function changeItalic(italic:Boolean) : ASFont
		{
			return new ASFont(this.name, this.size, this.color,this.bold, italic, this.underline, this.align);
		}
		
		public function isUnderline() : Boolean
		{
			return this.underline;
		}
		
		public function changeUnderline(underline:Boolean) : ASFont
		{
			return new ASFont(this.name, this.size, this.color,this.bold, this.italic, underline, this.align);
		}
		
		public function apply(textField:TextField, beginIndex:int = -1, endIndex:int = -1) : void
		{
			textField.setTextFormat(this.textFormat, beginIndex, endIndex);
			textField.defaultTextFormat = this.textFormat;
		}
		
		public function getTextFormat() : TextFormat
		{
			return new TextFormat(this.name, this.size, this.color, this.bold, this.italic, this.underline, null, null, this.align);
		}
		
		/**
		 * Computes text size with this font.
		 * @param text the text to be compute
		 * @includeGutters whether or not include the 2-pixels gutters in the result
		 * @return the computed size of the text
		 * 
		 */		
		public function computeTextSize(text:String, includeGutters:Boolean = true) : IntDimension
		{
			return PoolUtils.computeStringSizeWithFont(this, text, includeGutters);
		}
		

	}
	

		
}