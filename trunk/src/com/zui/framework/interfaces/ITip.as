package com.zui.framework.interfaces
{
	import flash.display.DisplayObject;

	public interface ITip extends IDispose
	{
		 
		function setTipString(str:String):void;
		function getTipString():void;
		
		function getDisplayObject():DisplayObject;
		function setDisplayObject(obj:DisplayObject):void;
	}
}