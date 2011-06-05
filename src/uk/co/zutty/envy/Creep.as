package uk.co.zutty.envy
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.Alarm;

	public class Creep extends Thing {
		
		private const FADE_RATE:Number = 0.03;
		
		[Embed(source = '/data/smallalien.png')]
		private const SMALLALIEN_IMAGE:Class;
		
		private var speed:Number;
		private var waypoint:Waypoint;
		private var direction:Vector2D;
		private var img:Image;
		private var spawnCallback:Function;
		
		public function Creep() {
			super();
			img = new Image(SMALLALIEN_IMAGE);
			img.alpha = 0.0;
			img.smooth = true;
			img.originX = img.originY = 12;
			graphic = img;
			speed = 3;
			health = 3;
			setHitbox(24, 24);
		}
		
		public function goTo(waypoint:Waypoint):void {
			this.waypoint = waypoint;
			direction = Vector2D.unitVector(x, y, waypoint.x, waypoint.y);
		}
				
		override public function update():void {
			if(img.alpha < 1.0) {
				img.alpha += Math.min(FADE_RATE, 1.0);
				img.scale = img.alpha;
				img.angle = (img.alpha * 500) + 220;
				
				if(img.alpha == 1.0 && spawnCallback != null) {
					spawnCallback();
				}
			} else if(waypoint != null) {
				if(waypoint.distanceTo(x, y) <= speed) {
					x = waypoint.x;
					y = waypoint.y;
					goTo(waypoint.next);
				} else {
					x += direction.x * speed;
					y += direction.y * speed;
				}
			}
			
			var b:Bullet = collide("bullet", x, y) as Bullet;
			if(b) {
				b.destroy();
				hurt();
			}
		}
		
		public function onSpawn(cb:Function):void {
			spawnCallback = cb;
		}
	}
}