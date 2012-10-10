package uk.co.zutty.envy.entity
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import uk.co.zutty.envy.Vector2D;
	import uk.co.zutty.envy.path.Node;

	public class Player extends Hurtable {
		
        [Embed(source = 'assets/alien.png')]
		private const ALIEN_IMAGE:Class;
		
		private var _speed:Number;
		private var _direction:Vector2D;
        private var _gfx:Image;
        private var _blueprint:Blueprint;
		
		public function Player() {
			super();
            
            _gfx = new Image(ALIEN_IMAGE);
            _gfx.centerOrigin();
			graphic = _gfx;

            _blueprint = null;
            _speed = 3;
			maxHealth = 10;
			setHitbox(48, 48, 24, 24);
            type = "creep";
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
                if(_blueprint && _blueprint.buildable) {
                    var s:Spawner = new Spawner();
                    s.x = _blueprint.x + 24;
                    s.y = _blueprint.y + 24;
                    gameworld.add(s);
                    
                    gameworld.recycle(_blueprint);
                    _blueprint = null;
                } else if(!_blueprint) {
                    _blueprint = gameworld.create(Blueprint) as Blueprint;
                }
			}

            if(_blueprint) {
                _blueprint.x = Math.round((x-24)/48) * 48;
                _blueprint.y = Math.round((y-24)/48) * 48;
            }
		}
	}
}