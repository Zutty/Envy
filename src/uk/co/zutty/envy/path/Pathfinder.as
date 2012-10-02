package uk.co.zutty.envy.path
{
    import flash.geom.Point;
    import flash.utils.Dictionary;
    
    import uk.co.zutty.envy.Waypoint;
    import uk.co.zutty.envy.levels.NavGraph;
    
    public class Pathfinder {
        
        private var _neighbors:Vector.<Point>;
        
        public function Pathfinder() {
            _neighbors = new Vector.<Point>();
            for(var i:int = 0; i < 4; i++) {
                _neighbors[i] = new Point();
            }
        }
        
        public function findPath(fromX:int, fromY:int, goalX:int, goalY:int, navGraph:NavGraph, tileW:Number, tileH:Number):Waypoint {
            var h:Function = function (x:int, y:int):Number { return distManhattan(x, y, goalX, goalY); }
            var open:Vector.<Node> = new Vector.<Node>();
            var closed:Dictionary = new Dictionary();

            // Add root node
            open[0] = new Node(fromX, fromY, 0, h(fromX, fromY), null);
            
            while(open.length > 0) {
                var current:Node = open.shift();
                
                if(current.x == goalX && current.y == goalY) {
                    return walkReverse(current, tileW, tileH);
                }
                
                closed[toTileNum(current.x, current.y, navGraph)] = 1;
                
                // Get neighbors
                for each(var n:Point in neighbors(current)) {
                    if(navGraph.isNavigable(n.x, n.y) && !(toTileNum(n.x, n.y, navGraph) in closed)) {
                        open.push(new Node(n.x, n.y, current.cost + 1, h(n.x, n.y), current));
                    }
                }
                     
                // Sort the open list
                open.sort(Node.byCost);
            }
            
            return null;
        }
        
        private function toTileNum(x:int, y:int, n:NavGraph):int {
            return (y * n.width) + x;
        }
        
        private function neighbors(node:Node):Vector.<Point> {
            _neighbors[0].x = node.x-1;
            _neighbors[0].y = node.y;
            
            _neighbors[1].x = node.x;
            _neighbors[1].y = node.y-1;

            _neighbors[2].x = node.x+1;
            _neighbors[2].y = node.y;

            _neighbors[3].x = node.x;
            _neighbors[3].y = node.y+1;

            return _neighbors;
        }
        
        private function walkReverse(node:Node, tileW:Number, tileH:Number):Waypoint {
            var path:Waypoint = null;
            var walk:Node = node;
            
            while(walk != null) {
                path = new Waypoint((walk.x * tileW) + (tileW/2), (walk.y * tileH) + (tileH/2), path);
                walk = walk.parent;
            }

            return path;
        }
        
        private static function distManhattan(x1:Number, y1:Number, x2:Number, y2:Number):Number {
            return Math.abs(x2-x1) + Math.abs(y2 - y1); 
        }
    }
}