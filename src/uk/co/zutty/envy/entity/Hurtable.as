package uk.co.zutty.envy.entity
{
    import net.flashpunk.FP;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    
    public class Hurtable extends EnvyEntity {
        
        private var _maxHealth:Number = 0;
        private var _health:Number = 0;
        
        public function Hurtable(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) {
            super(x, y, graphic, mask);
        }
        
        override public function added():void {
            _health = _maxHealth; 
        }
        
        public function get maxHealth():Number {
            return _maxHealth;
        }
        
        public function set maxHealth(mh:Number):void {
            _maxHealth = mh;
            _health = _maxHealth;
        }
        
        public function get health():Number {
            return _health;
        }
        
        public function set health(h:Number):void {
            _health = h;
        }
        
        public function hurt():void {
            _health--;
            if(_health <= 0) {
                gameworld.recycle(this);
            }
        }
    }
}