package uk.co.zutty.envy
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class EnvyEntity extends Entity {
		
		public function EnvyEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) {
			super(x, y, graphic, mask);
		}
		
		protected function get gameworld():GameWorld {
			return (FP.world is GameWorld) ? FP.world as GameWorld : null;
		}
				
		public function setPos(pos:Vector2D):void {
			x = pos.x;
			y = pos.y;
		}
	}
}