package uk.co.zutty.envy.entity
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	
	import uk.co.zutty.envy.RotatedSpritemap;
	import uk.co.zutty.envy.Vector2D;

	public class GunTower extends Tower {
			
		private const FIRE_FRAMES:uint = 15;
		
		[Embed(source = 'assets/gun_tower.png')]
		private const GUN_TOWER_IMAGE:Class;

		private var _fireTime:uint = 0;
		
		public function GunTower() {
			super(GUN_TOWER_IMAGE, 30, 100);
			
			_gfx.addRotated("fire", [1, 0], 0.3);
			_gfx.playRotated("turn");
		}
		
		override public function fire(target:Entity):void {
			(target as Hurtable).hurt();
			var ricochet:Entity = world.create(Ricochet);
			ricochet.x = target.x;
			ricochet.y = target.y;

			_gfx.playRotated("fire");
			_fireTime = FIRE_FRAMES;
		}
		
		override public function update():void {
			super.update();
			
			if(_fireTime > 0) {
				_fireTime--;
				if(_fireTime == 0) {
					_gfx.playRotated("turn");
				}
			}
		}
	}
}