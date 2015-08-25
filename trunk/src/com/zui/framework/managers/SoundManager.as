package com.zui.framework.managers
{
	import flash.display.SimpleButton;
	import flash.net.drm.VoucherAccessInfo;
	import flash.trace.Trace;
	
	import com.zui.framework.asAudio.Track;
	import com.zui.framework.utils.HashMap;

	public class SoundManager
	{
		public static const BACK_GROUND:int = 1;
		public static const EFFECT:int = 2;
		private var musicMap:HashMap = new HashMap();
		
		private var volumeMap:HashMap = new HashMap();
		private var switchMap:HashMap = new HashMap();
		private var backgroundTrack:Track;
		
		public function SoundManager()
		{
		}
		
		
		private static var _instance:SoundManager;
		
		public function playBackground(name:String,loop:Boolean = true,fadeIn:Boolean = true):void{
			if(switchMap.getValue(SoundManager.BACK_GROUND) == null){
				switchMap.put(SoundManager.BACK_GROUND,true);
			}
			
			
			if(switchMap.getValue(SoundManager.BACK_GROUND) as Boolean == true){
				if(backgroundTrack == null){
					backgroundTrack = new Track(name+".mp3");
				}else{
					backgroundTrack.stop();
					backgroundTrack.clear();
					backgroundTrack = new Track(name+".mp3");
				}
					
			
				if(volumeMap.get(SoundManager.BACK_GROUND) == null){
					volumeMap.put(SoundManager.BACK_GROUND,1);
				}
				backgroundTrack.volume = volumeMap.get(SoundManager.BACK_GROUND) as Number;
				backgroundTrack.loop = loop;
				backgroundTrack.start(fadeIn);
				
			}
			
		}
		public function playSound(name:String,loop:Boolean = false,fadeIn:Boolean = false):void{
			if(switchMap.getValue(SoundManager.EFFECT) == null){
				switchMap.put(SoundManager.EFFECT,true);
			}
			
			if(musicMap.getValue(name) == null){
				var track:Track = new Track(name+".mp3");
				musicMap.put(name,track);
			}else{
				track = musicMap.getValue(name);
			}

			track.stop();
			if(volumeMap.get(SoundManager.EFFECT) == null){
				volumeMap.put(SoundManager.EFFECT,1);
			}
			track.volume = volumeMap.get(SoundManager.EFFECT) as Number;
			track.loop = loop;
			track.start(fadeIn);
			
		}
		
		public function stopBackground(fadeOut:Boolean = true):void{
			if(backgroundTrack){
				backgroundTrack.stop(fadeOut);
			}
		}
		
		public function stopSound(name:String,fadeOut:Boolean = false):void{
			if(musicMap.get(name)!=null){
				var track:Track =  musicMap.getValue(name) as Track;
				track.stop(fadeOut);
			}
		}
		
		private function closeAll():void{
			
		}

		



		public static function get instance():SoundManager
		{
			if(_instance == null){
				_instance = new SoundManager();
			}
			return _instance;
		}

		public function setSwitch(value:Boolean,musicType:int):void{
			switchMap.put(musicType,value);
			if(musicType == SoundManager.BACK_GROUND){
				if(backgroundTrack){
					if(value){
						backgroundTrack.resume(true);
					}else{
						backgroundTrack.pause(true);
					}
				}
				
			}else{
				if(value == false){
					musicMap.eachValue(onStopMusic);
				}
			}
			
			
			
		}
		
		private function onStopMusic(track:Track):void{
			track.stop();
		}
		
		public function setVolume(volume:Number,soundType:int):void{
			volumeMap.put(soundType,volume);
			if(soundType == SoundManager.BACK_GROUND){
				if(backgroundTrack){
					backgroundTrack.volume = volume;
				}
			}else{
				musicMap.eachValue(onChangeVolume);
			}
		}
		
		private function onChangeVolume(track:Track):void{
			track.volume = volumeMap.get(SoundManager.EFFECT);
		}



	}
}