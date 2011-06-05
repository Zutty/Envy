package uk.co.zutty.envy
{
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class GameWorld extends World {
		
		private var _creeps:Vector.<Creep>;
		private var a:Waypoint;
		private var time:uint;
		
		public function GameWorld() {
			time = 0;
			
			var p:Player = new Player();
			p.x = 48;
			p.y = 48;
			add(p);

			var s:Spawner = new Spawner();
			s.x = 96;
			s.y = 96;
			add(s);

			var base:EarthBase = new EarthBase();
			base.x = 384;
			base.y = 96;
			add(base);

			var d:Waypoint = new Waypoint(48*1, 48*4);
			var c:Waypoint = new Waypoint(48*1, 48*7, d);
			var b:Waypoint = new Waypoint(48*6, 48*7, c);
			a = new Waypoint(48*6, 48*4, b);
			d.next = a;
			
			_creeps = new Vector.<Creep>();
			//spawnCreep();
			add(new Tower(0, 0));
			add(new Tower(48, 0));
		}
		
		public function get creeps():Vector.<Creep> {
			return _creeps;
		}
		
		public function nearestWaypoint(x:Number, y:Number):Waypoint {
			return a;
		}
	}
}