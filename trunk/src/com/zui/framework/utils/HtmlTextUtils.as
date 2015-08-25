package com.zui.framework.utils
{
	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-7-9 下午03:59:20
	 * 
	 * html 转换类
	 */
	public class HtmlTextUtils
	{
		//======================================================================
		//        property
		//======================================================================
		
		//======================================================================
		//        constructor
		//======================================================================
		
		public function HtmlTextUtils()
		{
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public static function createHtmlText(txt:String, size:int = 12, color:String = "000000", font:String = "Microsoft YaHei", bold:Boolean = false, leading:int = -1) : String
		{
			var html:String = "";
			html = "" + "<font";
			html = html + (" face='" + font + "'");
			html = html + (" color='#" + color + "'");
			html = html + (" size='" + size + "'");
			html = html + ">";
			if (bold)
			{
				html = html + "<b>";
			}
			html = html + txt;
			if (bold)
			{
				html = html + "</b>";
			}
			html = html + "</font>";
			if (leading != -1)
			{
				html = "<textformat leading=" + leading + ">" + html + "</textformat>";
			}
			return html;
		}
		
		public static function alignText(txt:String, align:String = "center") : String
		{
			var str:String = "<p align=\'" + align + "\'>" + txt + "</p>";
			return str;
		}
		
		public static function addLink(eventText:String,txt:String,underLine:Boolean = true):String{
			if(underLine){
				return "<u><a href='event:"+eventText+"'>"+txt+"</a></u>";
			}else{
				return "<a href='event:"+eventText+"'>"+txt+"</a>";
			}
			
		}
		
		public static function addUnderLine(txt:String):String{
			return "<u>"+txt+"</u>";
		}

		//======================================================================
		//        private function
		//======================================================================
		
		//======================================================================
		//        event handler
		//======================================================================
		
		//======================================================================
		//        getter&setter
		//======================================================================
		
		
	}
} 