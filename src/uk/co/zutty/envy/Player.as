package uk.co.zutty.envy
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import uk.co.zutty.envy.path.Node;

	public class Player extends Thing {
		
		[Embed(source = 'assets/alien.png')]
		private const ALIEN_IMAGE:Class;
		
		private var _speed:Number;
		private var _direction:Vector2D;
        private var _gfx:Image;
		
		public function Player() {
			super();
            
            _gfx = new Image(ALIEN_IMAGE);
            _gfx.centerOrigin();
			graphic = _gfx;

            _speed = 3;
			health = 10;
			setHitbox(48, 48, 24, 24);
		}
		
		override public function update():void {
			if(Input.check(Key.RIGHT)) {
				x += _speed;
			} else if(Input.check(Key.LEFT)) {
				x -= _speed;
			}
			if(Input.check(Key.UP)) {
				y -= _speed;
			} else if(Input.check(Key.DOWN)) {
				y += _speed;
			}
			
			if(Input.pressed(Key.SPACE)) {
				var s:Spawner = new Spawner();
				s.x = x;
				s.y = y;
				gameworld.add(s);
			}
			
			var b:Bullet = collide("bullet", x, y) as Bullet;
			if(b) {
				b.destroy();
				hurt();
			}
		}
	}
}