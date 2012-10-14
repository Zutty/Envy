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
    
    public class Tower extends Entity {
        
        private const FIRING_TIME:uint = 100;
        private const RANGE:uint = 250;
        
		[Embed(source = 'assets/turret_flat.png')]
		private const TOWER_IMAGE:Class;

		[Embed(source = 'assets/tower_base.png')]
        private const TOWER_BASE_IMAGE:Class;
        
        [Embed(source = 'assets/tower_gun.png')]
        private const TOWER_GUN_IMAGE:Class;
        
        private var _gun:RotatedSpritemap; 
        private var _time:uint;
        
        public function Tower(x:Number, y:Number) {
            super(x, y);
            
            //var base:Image = new Image(TOWER_BASE_IMAGE);
            //addGraphic(base);
            
            _gun = new RotatedSpritemap(TOWER_IMAGE, 48, 48); //Image(TOWER_GUN_IMAGE);
            //_gun.smooth = true;
            //addGraphic(_gun);
			graphic = _gun;
            
            setHitbox(48, 48, 0, 0);
            type = "building";
        }
        
        override public function update():void {
            super.update();
            
            _time++;
            
            var target:Entity = world.nearestToEntity("creep", this);
            
            if(target != null && distanceFrom(target, true) <= RANGE) {
                var cx:Number = x + (width/2);
                var cy:Number = y + (height/2);
                var dx:Number = cx - target.x;
                var dy:Number = cy - target.y;
                _gun.frameAngle = (Math.atan2(dx, dy) * 180/Math.PI);
                
                if(_time > FIRING_TIME) {
                    _time = 0;
                    var rocket:Rocket = world.create(Rocket) as Rocket;
                    rocket.x = cx;
                    rocket.y = cy;
                    rocket.target = new Vector2D(target.x, target.y); 
                }
            }
        }
    }
}