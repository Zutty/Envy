package uk.co.zutty.envy.entity
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.Alarm;
	import uk.co.zutty.envy.Vector2D;
	import uk.co.zutty.envy.Waypoint;

	public class Creep extends Hurtable {
		
		private const FADE_RATE:Number = 0.03;
		
		[Embed(source = 'assets/smallalien.png')]
		private const SMALLALIEN_IMAGE:Class;
		
		private var _speed:Number;
		private var _waypoint:Waypoint;
		private var _direction:Vector2D;
		private var _img:Image;
		private var _spawnCallback:Function;
		
		public function Creep() {
			super();
			_img = new Image(SMALLALIEN_IMAGE);
			_img.smooth = true;
			_img.centerOrigin();
			graphic = _img;
			_speed = 3;
			maxHealth = 1;
			setHitbox(24, 24, 12, 12);
            type = "creep";
		}
        
        override public function added():void {
            super.added();
            
            _img.alpha = 0.0;
        }
		
		public function goTo(waypoint:Waypoint):void {
            if(waypoint) {
    			_waypoint = waypoint;
    			_direction = Vector2D.unitVector(x, y, _waypoint.x, _waypoint.y);
            }
		}
				
		override public function update():void {
			if(_img.alpha < 1.0) {
				_img.alpha += Math.min(FADE_RATE, 1.0);
				_img.scale = _img.alpha;
				_img.angle = (_img.alpha * 500) + 220;
				
				if(_img.alpha == 1.0 && _spawnCallback != null) {
					_spawnCallback();
				}
			} else if(_waypoint != null) {
				if(FP.distance(_waypoint.x, _waypoint.y, x, y) <= _speed) {
					x = _waypoint.x;
					y = _waypoint.y;
					goTo(_waypoint.next);
				} else {
					x += _direction.x * _speed;
					y += _direction.y * _speed;
				}
			}
			
            var eb:EarthBase = collide("building", x, y) as EarthBase;
            if(eb) {
                gameworld.recycle(this);
            }
        }
		
		public function onSpawn(cb:Function):void {
			_spawnCallback = cb;
		}
	}
}