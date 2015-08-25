package com.zui.framework.DragDataManager
{
	public interface IDragItem
	{
		function setContent(value:*):void;
		function getContent():*;
		
		function disposeContent():void;
	}
}