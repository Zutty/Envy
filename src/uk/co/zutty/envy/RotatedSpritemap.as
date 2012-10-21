package uk.co.zutty.envy
{
	import net.flashpunk.graphics.Anim;
	import net.flashpunk.graphics.Spritemap;
	
	public class RotatedSpritemap extends Spritemap {
		
		private var _rotationFrames:uint;
		private var _increment:Number;
		private var _currentAnim:String;
		private var _currentAngle:int;
		
		public function RotatedSpritemap(source:*, frameWidth:uint, frameHeight:uint, rotationFrames:uint, callback:Function=null) {
			super(source, frameWidth, frameHeight, callback);
			
			_rotationFrames = rotationFrames;
			_increment = 360 / _rotationFrames;
			
			_currentAnim = "";
			_currentAngle = 0;
		}
		
		public function addRotated(name:String, rows:Array, frameRate:Number=0, loop:Boolean=true):void {
			for(var i:uint = 0; i < _rotationFrames; i++) {
				add(animName(name, i), makeFrames(i, rows), frameRate, loop);
			}
			
			_currentAnim = name;
		}
		
		private function makeFrames(angle:int, rows:Array):Array {
			var frames:Array = [];
			
			for(var i:int = 0; i < rows.length; i++) {
				frames[i] = (rows[i] * _rotationFrames) + angle;
			}
			
			return frames;
		}
		
		public function playRotated(name:String):void {
			_currentAnim = name;
			play(animName(_currentAnim, _currentAngle));
		}
		
		public function set frameAngle(a:Number):void {
			_currentAngle = (Math.round(a / _increment) + (_rotationFrames / 2)) % _rotationFrames;
			play(animName(_currentAnim, _currentAngle));
		}
		
		private function animName(name:String, angle:int):String {
			return name + "_" + angle;
		}
	}
}