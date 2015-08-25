package com.zui.framework.utils
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.utils.ByteArray;

	public class ZMath
	{
		public function ZMath()
		{
		}
		
		
		
		public static function getDistance(x1:Number,y1:Number,x2:Number,y2:Number):Number{
			return Math.sqrt((x1- x2)*(x1- x2) + (y1 - y2)*(y1 - y2));
		}
		
		/**
		 * 获取一个displayObject真实大小的rect
		 * @param displayObject
		 * @return 
		 * 
		 */		
		public static function getByteLen(str:String):int{
			var len:int = -1;
			if(str != null){
				var ba:ByteArray =new ByteArray;
				ba.writeMultiByte (str,"");
				len = ba.length;
			}
			return len;
		}
		
		static public function getFullBounds ( displayObject:DisplayObject ) :Rectangle  
			
		　　{　　　var bounds:Rectangle, transform:Transform,  
			
			　　　　toGlobalMatrix:Matrix, currentMatrix:Matrix;  
			
			　　　　transform = displayObject.transform;  
			
			　　　　currentMatrix = transform.matrix;  
			
			　　　　toGlobalMatrix = transform.concatenatedMatrix;  
			
			　　　　toGlobalMatrix.invert();  
			
			　　　　transform.matrix = toGlobalMatrix;  
			
			
			
			　　　　bounds = transform.pixelBounds.clone();  
			
			
			
			　　　　transform.matrix = currentMatrix;  
			
			　　　　return bounds;  
			
		　　} 
	}
}