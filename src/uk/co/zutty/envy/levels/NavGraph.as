package uk.co.zutty.envy.levels
{
    import flash.geom.Point;
    import flash.utils.Dictionary;
    
    import net.flashpunk.FP;

    public class NavGraph {

        private var _width:int;
        private var _height:int;
        private var _navPoints:Dictionary;

        public function NavGraph(width:int, height:int) {
            _width = width;
            _height = height;
            _navPoints = new Dictionary();
        }
        
        public function get width():int {
            return _width;
        }
        
        public function get height():int {
            return _height;
        }
        
        public function isNavigable(x:int, y:int):Boolean {
            if(x < 0 || x > _width || y < 0 || y > _height) {
                return false;
            }
            
            var tile:int = toTileNum(x, y);
            return tile in _navPoints;
        }
        
        public function setNavigable(x:int, y:int):void {
            var tile:int = toTileNum(x, y);
            _navPoints[tile] = 1;
        }
        
        public function getNearestPoint(x:int, y:int):Point {
            var nearest:int = 0;
            var nearDist:Number = 65536;
            
            for(var tile:* in _navPoints) {
                var tx:int = int(tile) % _width;
                var ty:int = int(tile) / _width;
                var dist:Number = FP.distance(x, y, tx, ty);
                
                if(dist < nearDist) {
                    nearDist = dist;
                    nearest = tile;
                }
            }
            
            return new Point(nearest % _width, Math.floor(nearest / _width))
        }
        
        private function toTileNum(x:int, y:int):int {
            return (_width * y) + x;
        }
    }
}