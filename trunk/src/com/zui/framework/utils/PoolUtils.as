package com.zui.framework.utils
{
	import flash.text.TextField;
	
	import com.zui.framework.geom.IntDimension;

	public class PoolUtils
	{
		private static var TEXT_FIELD:TextField = new TextField();
		private static var TEXT_FONT:ASFont = null;
		private static var TEXT_FIELD_EXT:TextField = new TextField();
		
		public function PoolUtils()
		{
		}
		
		/**
		 * Computes the text size of specified font, text.
		 * @param tf the font of the text
		 * @param str the text to be computes
		 * @param includeGutters whether or not include the 2-pixels gutters in the result
		 * @return the computed size of the text
		 */
		public static function computeStringSizeWithFont(font:ASFont, str:String, includeGutters:Boolean=true):IntDimension{

			TEXT_FIELD_EXT.text = str;
			font.apply(TEXT_FIELD_EXT);
			if(includeGutters){
				return new IntDimension(Math.ceil(TEXT_FIELD_EXT.width), Math.ceil(TEXT_FIELD_EXT.height));
			}else{
				return new IntDimension(Math.ceil(TEXT_FIELD_EXT.textWidth), Math.ceil(TEXT_FIELD_EXT.textHeight));
			}
			
		
		} 
	}
}