package uk.co.zutty.envy
{
    import flash.geom.Point;
    
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.World;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
    
    import uk.co.zutty.envy.entity.EarthBase;
    import uk.co.zutty.envy.entity.Player;
    import uk.co.zutty.envy.entity.Tower;
    import uk.co.zutty.envy.levels.Level1;
    import uk.co.zutty.envy.levels.NavGraph;
    import uk.co.zutty.envy.levels.OgmoLevel;
    import uk.co.zutty.envy.path.Pathfinder;
    
    public class GameWorld extends World {
        
        private var _level:OgmoLevel;
        private var _player:Player;
        private var _navGraph:NavGraph;
        private var _pathfinder:Pathfinder;
        private var _time:uint = 0;
        
        public function GameWorld() {
            loadLevel(new Level1());
            
            _player = new Player();
            _player.x = 48;
            _player.y = 48;
            add(_player);
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