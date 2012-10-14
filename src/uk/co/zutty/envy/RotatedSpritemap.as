package uk.co.zutty.envy
{
	import net.flashpunk.graphics.Spritemap;
	
	public class RotatedSpritemap extends Spritemap {
		
		private var _increment:Number;
		
		public function RotatedSpritemap(source:*, frameWidth:uint=0, frameHeight:uint=0, callback:Function=null) {
			super(source, frameWidth, frameHeight, callback);
			
			_increment = 360 / frameCount;
			
			for(var i:uint; i < frameCount; i++) {
				add(String(i), [i]);
			}
		}
		
		public function set frameAngle(a:Number):void {
			var n:uint = (Math.round(a / _increment) + 16) % frameCount;
			play(String(n));
		}
	}
}