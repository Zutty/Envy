package uk.co.zutty.envy
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import uk.co.zutty.envy.levels.Level1;
	import uk.co.zutty.envy.levels.OgmoLevel;
	
	public class GameWorld extends World {
		
        private var _level:OgmoLevel;
		private var _creeps:Vector.<Creep>;
        private var _player:Player;
		private var a:Waypoint;
		private var time:uint;
		
		public function GameWorld() {
			time = 0;
            
            loadLevel(new Level1());
			
			_player = new Player();
			_player.x = 48;
			_player.y = 48;
			add(_player);

			//var s:Spawner = new Spawner();
			//s.x = 96;
			//s.y = 96;
			//add(s);

			//var base:EarthBase = new EarthBase();
			//base.x = 384;
			//base.y = 96;
			//add(base);

			//var d:Waypoint = new Waypoint(48*1, 48*4);
			//var c:Waypoint = new Waypoint(48*1, 48*7, d);
			//var b:Waypoint = new Waypoint(48*6, 48*7, c);
			//a = new Waypoint(48*6, 48*4, b);
			//d.next = a;
			
			_creeps = new Vector.<Creep>();
			//spawnCreep();
			//add(new Tower(0, 0));
			//add(new Tower(48, 0));
		}
		
        private function loadLevel(lvl:OgmoLevel):void {
            _level = lvl;
            add(lvl.getLayer("ground"));
            add(lvl.getLayer("roads"));
            
            var p:Point;
            for each(p in _level.getObjectPositions("buildings", "base")) {
                var b:EarthBase = new EarthBase();
                b.x = p.x;
                b.y = p.y;
                add(b);
            }

            for each(p in _level.getObjectPositions("buildings", "tower")) {
                add(new Tower(p.x, p.y));
            }
}
        
		public function get creeps():Vector.<Creep> {
			return _creeps;
		}
		
		public function nearestWaypoint(x:Number, y:Number):Waypoint {
			return a;
		}
        
        override public function update():void {
            super.update();
            
            camFollow(_player);
        }
        
        public function camFollow(e:Entity):void {
            FP.camera.x = FP.clamp(e.x - FP.width/2, 0, 1440 - FP.width);            
            FP.camera.y = FP.clamp(e.y - FP.height/2, 0, 960 - FP.height);            
        }
	}
}