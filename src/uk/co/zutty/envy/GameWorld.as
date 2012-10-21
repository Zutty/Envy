package uk.co.zutty.envy
{
    import flash.geom.Point;
    
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Text;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
    
    import uk.co.zutty.envy.entity.EarthBase;
    import uk.co.zutty.envy.entity.GunTower;
    import uk.co.zutty.envy.entity.Hud;
    import uk.co.zutty.envy.entity.Hurtable;
    import uk.co.zutty.envy.entity.Player;
    import uk.co.zutty.envy.entity.RocketTower;
    import uk.co.zutty.envy.entity.Spawner;
    import uk.co.zutty.envy.entity.Tower;
    import uk.co.zutty.envy.levels.Level1;
    import uk.co.zutty.envy.levels.NavGraph;
    import uk.co.zutty.envy.levels.OgmoLevel;
    import uk.co.zutty.envy.path.Pathfinder;
    
    public class GameWorld extends World {
        
        private static const STATE_PLAY:uint = 1; 
        private static const STATE_WIN:uint = 1; 
        private static const STATE_LOSE:uint = 1; 
        
        private var _level:OgmoLevel;
        private var _player:Player;
        private var _navGraph:NavGraph;
        private var _pathfinder:Pathfinder;
        private var _time:uint = 0;
        private var _hud:Hud;
        private var _state:uint;
        
        override public function begin():void {
            _state = STATE_PLAY;
            
            loadLevel(new Level1());
            
            _player = new Player();
            _player.x = 48;
            _player.y = 48;
            add(_player);

            _hud = new Hud();
            add(_hud);
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
                b.callback = destroyBase;
                add(b);
            }
            
            for each(p in _level.getObjectPositions("buildings", "rocket-tower")) {
				var rtower:RocketTower = new RocketTower();
				rtower.x = p.x;
				rtower.y = p.y
                add(rtower);
            }
			for each(p in _level.getObjectPositions("buildings", "gun-tower")) {
				var gtower:GunTower = new GunTower();
				gtower.x = p.x;
				gtower.y = p.y
				add(gtower);
			}
            
            _navGraph = _level.getNavGraph("roads");
            _pathfinder = new Pathfinder(_navGraph, _level.tileWidth, _level.tileHeight);
        }
        
        public function getPathFrom(x:Number, y:Number):Waypoint {
            var tx:int = Math.floor(x / _level.tileWidth);
            var ty:int = Math.floor(y / _level.tileHeight);
            var from:Point = _navGraph.getNearestPoint(tx, ty);
            
            var goal:Point = _level.getObjectPosition("goals", "maingoal");
            var gx:int = goal.x / _level.tileWidth;
            var gy:int = goal.y / _level.tileHeight;
            
            var path:Waypoint = _pathfinder.findPath(from.x, from.y, gx, gy);
            
            return path;
        }
        
        override public function update():void {
            super.update();
            
            camFollow(_player);
            
            var base:Hurtable = classFirst(EarthBase) as Hurtable;
            if(base != null) {
                _hud.baseHealth = base.healthPct;
            }
        }
        
        public function destroyBase():void {
            if(_state == STATE_PLAY) {
                _state = STATE_WIN;
                
                var txt:Text = new Text("Hooray!", 320, 240, {size:72, align: "center"});
                txt.centerOrigin();
                txt.scrollX = 0;
                txt.scrollY = 0;
                addGraphic(txt);
                
                var spawners:Array = [];
                getClass(Spawner, spawners);
                for each(var s:Spawner in spawners) {
                    s.spawn = false;
                }

                var towers:Array = [];
                getClass(Tower, towers);
                for each(var t:Tower in towers) {
                    t.activated = false;
                }
            }
        }
        
        public function camFollow(e:Entity):void {
            FP.camera.x = FP.clamp(e.x - FP.width/2, 0, _level.width - FP.width);            
            FP.camera.y = FP.clamp(e.y - FP.height/2, 0, _level.height - FP.height);            
        }

        public function isOutOfBounds(e:Entity):Boolean {
            return (e.x - e.width) < 0 || (e.x + e.width) > _level.width 
                || (e.y - e.height) < 0 || (e.y + e.height) > _level.height;
        }
    }
}