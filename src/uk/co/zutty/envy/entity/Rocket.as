package uk.co.zutty.envy.entity
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import uk.co.zutty.envy.Vector2D;
	
	public class Rocket extends EnvyEntity {
	
        private const ARC_FACTOR:Number = 7;
		private const SPEED:Number = 4;
		
		[Embed(source = 'assets/rocket.png')]
		private static const BULLET_IMAGE:Class;
		
        private var _gfx:Spritemap;
        private var _target:Vector2D;
        private var _dir:Vector2D = new Vector2D(0, 0);
        private var _range:Number;
        private var _z:Number;
		
		public function Rocket() {
			super();
            
            _gfx = new Spritemap(BULLET_IMAGE, 24, 24);
            _gfx.centerOrigin();
            _gfx.add("fire", [0, 1], 0.2);
            _gfx.play("fire");
			graphic = _gfx;

            setHitbox(24, 24, 12, 12);
			type = "bullet";
		}
        
        public function set target(target:Vector2D):void {
            _target = target;
            _range = FP.distance(x, y, _target.x, _target.y);
            _z = .5;
            _dir.x = _target.x - x;
            _dir.y = _target.y - y;
            _dir.normalise(SPEED);
        }
        
		public function destroy():void {
			gameworld.recycle(this);
		}

		override public function update():void {
            super.update();
            
            _z -= SPEED / _range;
            var dy:Number = _dir.y - (_z * ARC_FACTOR);
            moveBy(_dir.x, dy);
            
            _gfx.angle = (Math.atan2(_dir.x, dy) * 180/Math.PI) + 90;

            if(distanceToPoint(_target.x, _target.y) <= SPEED * 1.5) {
                destroy();
                
                var asplosion:Entity = gameworld.create(Asplosion);
                asplosion.x = x;
                asplosion.y = y;
            }
		}
    }
}