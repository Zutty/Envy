package uk.co.zutty.envy.nav
{
    import flash.utils.Dictionary;
    
    import net.flashpunk.FP;

    public class NavMesh {
        
        private var _nodes:Dictionary;
        
        public function NavMesh() {
            _nodes = new Dictionary();
        }
        
        public function addNode(n:NavNode):void {
            _nodes[n.id] = n;
        }
        
        public function getNode(id:int):NavNode {
            return _nodes[id];
        }
        
        public function nearest(x:Number, y:Number):NavNode {
            var nearest:int = -1;
            var nearDist:Number = 65535;
            
            for each(var n:NavNode in _nodes) {
                var dist:Number = FP.distance(x, y, n.x, n.y);
                if(dist <= nearDist) {
                    nearest = n.id;
                    nearDist = dist;
                }
            }
            
            return _nodes[nearest];
        } 
    }
}