package uk.co.zutty.envy
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	
	public class Tower extends EnvyEntity {
		
		private const FIRING_TIME:uint = 100;
        private const RANGE:uint = 250;
		
		[Embed(source = 'assets/tower_base.png')]
		private const TOWER_BASE_IMAGE:Class;

		[Embed(source = 'assets/tower_gun.png')]
		private const TOWER_GUN_IMAGE:Class;
		
		private var _gun:Image; 
		private var _time:uint;

		public function Tower(x:Number, y:Number) {
			super(x, y);

            var base:Image = new Image(TOWER_BASE_IMAGE);
			addGraphic(base);
            
			_gun = new Image(TOWER_GUN_IMAGE);
			_gun.smooth = true;
			_gun.centerOrigin();
            _gun.x = 24;
            _gun.y = 24;
			addGraphic(_gun);

            setHitbox(48, 48, 0, 0);
		}
		
		override public function update():void {
			super.update();

            _time++;
            
			var target:Entity = gameworld.nearestToEntity("creep", this);
            
			if(target != null && distanceFrom(target, true) <= RANGE) {
				var cx:Number = x + (width/2);
				var cy:Number = y + (height/2);
				var dx:Number = cx - target.x;
				var dy:Number = cy - target.y;
				_gun.angle = (Math.atan2(dx, dy) * 180/Math.PI);
				
				if(_time > FIRING_TIME) {
					_time = 0;
                    var rocket:Bullet = gameworld.create(Bullet) as Bullet;
                    rocket.x = cx;
                    rocket.y = cy;
                    rocket.target = new Vector2D(target.x, target.y); 
				}
			}
		}
	}
}