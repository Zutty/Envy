package uk.co.zutty.envy
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	public class Bullet extends EnvyEntity {
	
		private const SPEED:Number = 4;
		
		[Embed(source = 'assets/rocket.png')]
		private const BULLET_IMAGE:Class;
		
        private var _gfx:Spritemap;
		private var _direction:Vector2D;
		
		public function Bullet() {
			super();
            
            _gfx = new Spritemap(BULLET_IMAGE, 24, 24);
            _gfx.add("fire", [0, 1], 6);
            _gfx.centerOrigin();
            _gfx.play("fire");
			graphic = _gfx;
            
			setHitbox(24, 24, 12, 12);
			type = "bullet";
		}
        
        public function set direction(d:Vector2D):void {
            _direction = d;
        }
        
        //override public function added():void {
        //}
		
		public function destroy():void {
			gameworld.recycle(this);
		}

		override public function update():void {
            super.update();
            
			x += _direction.x * SPEED;
			y += _direction.y * SPEED;
            
            _gfx.angle = _direction.angle + 90;
			
			if(gameworld.isOutOfBounds(this)) {
				destroy();
			}
		}
}
}