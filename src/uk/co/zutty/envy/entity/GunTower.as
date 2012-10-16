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
			
		[Embed(source = 'assets/gun_tower.png')]
		private const GUN_TOWER_IMAGE:Class;
		
		public function GunTower() {
			super(GUN_TOWER_IMAGE, 30, 100);
		}
		
		override public function fire(target:Entity):void {
			(target as Hurtable).hurt();
			var ricochet:Entity = world.create(Ricochet);
			ricochet.x = target.x;
			ricochet.y = target.y;
		}
	}
}