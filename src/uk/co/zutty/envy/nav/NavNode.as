package uk.co.zutty.envy.nav
{
    public class NavNode {
        
        private var _x:Number;
        private var _y:Number;
        private var _id:int;
        private var _neighbors:Array;
        
        public function NavNode(id:int, x:Number, y:Number, neighborsStr:String) {
            _id = id;
            _x = x;
            _y = y;
            _neighbors = [];
            for each(var n:String in neighborsStr.split(",")) {
                _neighbors[_neighbors.length] = int(n);
            }
        }
        
        public function get id():int {
            return _id;
        }
        
        public function get x():Number {
            return _x;
        }
        
        public function get y():Number {
            return _y;
        }
        
        public function get neighbors():Array {
            return _neighbors;
        }
    }
}