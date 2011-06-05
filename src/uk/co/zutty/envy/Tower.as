package uk.co.zutty.envy
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	
	public class Tower extends Entity {
		
		private const FIRING_TIME:uint = 30;
		
		[Embed(source = '/data/tower_base.png')]
		private const TOWER_BASE_IMAGE:Class;

		[Embed(source = '/data/tower_gun.png')]
		private const TOWER_GUN_IMAGE:Class;
		
		private var gun:Image; 
		private var time:uint;

		public function Tower(x:Number, y:Number) {
			super(x, y);
			graphic = new Graphiclist();
			addGraphic(new Image(TOWER_BASE_IMAGE));
			gun = new Image(TOWER_GUN_IMAGE);
			gun.smooth = true;
			gun.centerOrigin();
			addGraphic(gun);
			width = 48;
			height = 48;
		}
		
		public function get nearestCreep():Creep {
			if(FP.world is GameWorld) {
				var gameWorld:GameWorld = (GameWorld)(FP.world);
				var creeps:Vector.<Creep> = gameWorld.creeps;
				var nearest:Creep = null;
				var nearDist:Number = 0;

				for each(var creep:Creep in creeps) {
					var dx:Number = creep.x - x;
					var dy:Number = creep.y - y;
					var dist:Number = Math.sqrt(dx*dx + dy*dy);
					
					if((nearest == null || dist < nearDist) && !creep.dead) {
						nearest = creep;
						nearDist = dist;
					}	
				}

				return nearest;
			} else {
				return null;
			}
		}
		
		override public function update():void {
			time++;
			super.update();
			var target:Creep = nearestCreep;
			if(target != null && !target.dead) {
				var cx:Number = x + (width/2);
				var cy:Number = y + (height/2);
				var dx:Number = cx - target.x;
				var dy:Number = cy - target.y;
				gun.angle = (Math.atan2(dx, dy) * 180/Math.PI);
				
				if(time > FIRING_TIME) {
					time = 0;
					FP.world.add(new Bullet(cx, cy, Vector2D.unitVector(cx, cy, target.x, target.y)));
				}
			}
		}
	}
}