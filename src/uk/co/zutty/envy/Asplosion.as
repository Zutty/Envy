package uk.co.zutty.envy
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Spritemap;
    
    public class Asplosion extends EnvyEntity {
        
        [Embed(source = 'assets/asplosion.png')]
        private static const ASPLOSION_IMAGE:Class;
        
        private var _gfx:Spritemap;
        private var _collided:Boolean;
        
        public function Asplosion() {
            super();
            
            _gfx = new Spritemap(ASPLOSION_IMAGE, 96, 96);
            _gfx.centerOrigin();
            _gfx.add("asplode", [0,1,2,3,4], 0.6, false);
            _gfx.callback = destroy;
            graphic = _gfx;
            
            setHitbox(96, 48, 48, 24);
            type = "asplosion";
        }
        
        public function destroy():void {
            FP.world.recycle(this);
        }
        
        override public function added():void {
            _collided = false;
            _gfx.play("asplode", true);
        }
        
        override public function update():void {
            super.update();
            
            if(!_collided) {
                var creeps:Array = [];
                collideInto("creep", x, y, creeps);
                
                for each(var creep:Thing in creeps) {
                    creep.hurt();
                }
                
                _collided = true;
            }
        }
    }
}