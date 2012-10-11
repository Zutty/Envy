package uk.co.zutty.envy
{
    import flash.geom.Point;
    
    import net.flashpunk.FP;
    
    public class Vector2D {
        
        public var x:Number;
        public var y:Number;
        
        public function Vector2D(x:Number, y:Number) {
            this.x = x;
            this.y = y;
        }
        
        public function multiply(scalar:Number):Vector2D {
            x *= scalar;
            y *= scalar;
            return this;
        }
        
        public function get magnitude():Number {
            return Math.sqrt(x*x + y*y);
        }
        
        public function get angle():Number {
            return (Math.atan2(x, y) * 180/Math.PI);
        }
        
        public function normalise(length:Number = 1):Vector2D {
            multiply(length / magnitude);
            return this;
        }
        
        public static function unitVector(ax:Number, ay:Number, bx:Number, by:Number):Vector2D {
            return new Vector2D(bx - ax, by - ay).normalise();
        }
    }
}