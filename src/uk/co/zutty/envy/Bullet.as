package uk.co.zutty.envy
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class Bullet extends Entity {
	
		private const SPEED:Number = 12;
		
		[Embed(source = '/data/bullet.png')]
		private const BULLET_IMAGE:Class;
		
		private var direction:Vector2D;
		
		public function Bullet(x:Number, y:Number, direction:Vector2D) {
			super(x, y);
			this.direction = direction;
			graphic = new Image(BULLET_IMAGE);
			setHitbox(4, 4);
			type = "bullet";
		}
		
		public function destroy():void {
			FP.world.remove(this);
		}

		override public function update():void {
			x += direction.x * SPEED;
			y += direction.y * SPEED;
			
			if(x < -width || x > FP.engine.width || y < -width || y > FP.engine.height) {
				destroy();
			}
		}
}
}