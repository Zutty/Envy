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
    
    public class RocketTower extends Tower {
        
		[Embed(source = 'assets/rocket_tower.png')]
		private const ROCKET_TOWER_IMAGE:Class;
        
        public function RocketTower() {
            super(ROCKET_TOWER_IMAGE, 100, 250);
        }
		
		override public function fire(target:Entity):void {
			var rocket:Rocket = world.create(Rocket) as Rocket;
			rocket.x = x + 24;
			rocket.y = y + 8;
			rocket.target = new Vector2D(target.x, target.y); 
		}
    }
}