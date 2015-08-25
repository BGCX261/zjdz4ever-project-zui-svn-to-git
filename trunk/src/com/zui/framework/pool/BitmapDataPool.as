package com.zui.framework.pool
{
	import com.dolo.arpg.debug.Debug;
	import com.dolo.arpg.globals.GameConfig;
	
	import flash.display.BitmapData;
	import flash.utils.Dictionary;

	/**
	 * @author zhoujun
	 * @E-mail: 214501728@qq.com
	 * @version 1.0.0
	 * creation time：2012-9-10 上午11:08:06
	 * 
	 */
	public class BitmapDataPool
	{
		//======================================================================
		//        property
		//======================================================================
		private var pool:Dictionary;
		private static var instance:BitmapDataPool;
		private var max:int = GameConfig.bmp_max_num;
		private var seqAry:Vector.<String> = new Vector.<String>;
		//======================================================================
		//        constructor
		//======================================================================
		
		public function BitmapDataPool()
		{
			this.pool = new Dictionary();
		}
		
		//======================================================================
		//        public function
		//======================================================================
		public function dispose(url:String) : void
		{
			var bitmapData:* = this.pool[url];
			if (bitmapData)
			{
				bitmapData.dispose();
				delete this.pool[url];
			}
			return;
		}
		
		public function getBitmapData(url:String) : BitmapData
		{
			if (url == "" || url == null)
			{
				return null;
			}

			var bitmapData:* = pool[url];
			if(bitmapData == null){
				return null;
			}
			var index:int = seqAry.indexOf(url);
			if(index!=-1){
				seqAry.splice(index,1);
				seqAry.push(url);
			}
			
			return bitmapData;
		}
		
		public function addBitmapData(url:String, bitmapData:BitmapData) : void
		{
			if(this.pool[url]==null || this.pool[url] == undefined){
				this.pool[url] = bitmapData;
				if(seqAry.length==max){
					dispose(seqAry[0]);
					seqAry.shift();
				}
				seqAry.push(url);
			}
			
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
		public static function getInstance() : BitmapDataPool
		{
			if (instance == null)
			{
				instance = new BitmapDataPool;
			}
			return instance;
		}
		
	}
} 