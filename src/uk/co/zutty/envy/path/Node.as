package uk.co.zutty.envy.path
{
    public class Node {
        
        private var _x:int;
        private var _y:int;
        private var _pathCost:Number;
        private var _heuristicCost:Number;
        private var _parent:Node;
        
        public function Node(x:int, y:int, pathCost:Number, heuristicCost:Number, parent:Node) {
            _x = x;
            _y = y;
            _pathCost = pathCost;
            _heuristicCost = heuristicCost;
            _parent = parent;
        }
        
        public function get x():int {
            return _x;
        }
        
        public function get y():int {
            return _y;
        }
        
        public function get pathCost():Number {
            return _pathCost;
        }

        public function get heuristicCost():Number {
            return _heuristicCost;
        }

        public function get cost():Number {
            return _pathCost + _heuristicCost;
        }
        
        public function get parent():Node {
            return _parent;
        }
        
        public function get isRoot():Boolean {
            return _parent == null;
        } 
        
        public static function byCost(a:Node, b:Node):Number {
            return b.cost - a.cost;
        }
    }
}