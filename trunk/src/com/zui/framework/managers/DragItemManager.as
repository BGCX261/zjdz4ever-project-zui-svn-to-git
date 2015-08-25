package com.zui.framework.managers
{
	/**
	 * @version 1.0.0
	 * creation time：2012-9-24 下午04:31:39
	 * 
	 */
	import com.dolo.arpg.engine.load.BulkFactroy;
	import com.dolo.arpg.globals.GameData;
	import com.dolo.arpg.globals.UrlConfig;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class DragItemManager
	{
		//======================================================================
		//        const variable
		//======================================================================
		private static var _instance:DragItemManager;
		//======================================================================
		//        static variable
		//======================================================================
		
		//======================================================================
		//        variable
		//======================================================================
		private var _info:*;
		private var _icon:Bitmap;
		private var _container:Sprite;
		private var _boxType:String;
		private var _copyType:String;
		
		private var _dragTarget:DisplayObject;
		private var _dragSource:DisplayObject;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function DragItemManager()
		{
			
		}
		
		
		
		//======================================================================
		//        function
		//======================================================================
		public static function getInstance():DragItemManager
		{
			if(_instance == null)
			{
				_instance=new DragItemManager();
			}
			return _instance;
		}
		public function disposInstance():void
		{
			_info=null;
			if(_icon && _icon.bitmapData){
				_icon.bitmapData.dispose();
			}
		}
		public function initDragItem():void
		{
			LayerManager.getInstance().stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
			LayerManager.getInstance().stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);

		}

		//======================================================================
		//        private function
		//======================================================================
		
		//======================================================================
		//        event handler
		//======================================================================
		private function mouseMoveHandler(e:MouseEvent):void
		{
			_icon.x=LayerManager.getInstance().stage.mouseX;
			_icon.y=LayerManager.getInstance().stage.mouseY;
			
			trace(_icon.x,_icon.y);
		}
		private function mouseUpHandler(e:MouseEvent):void
		{
			LayerManager.getInstance().stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
		}
		//======================================================================
		//        getter&setter
		//======================================================================
		public function set info(value:*):void
		{
			_info = value;
			_icon = BulkFactroy.getBulkBitmap(UrlConfig.SKILL_ICON+_info.showId+".jpg");
			LayerManager.getInstance().uiContainer.addChild(_icon);
			trace("dragItemManger");
		}

		public function get dragSource():DisplayObject
		{
			return _dragSource;
		}

		public function set dragSource(value:DisplayObject):void
		{
			_dragSource = value;
		}

		
	}
} 