package uk.co.zutty.envy.entity
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Spritemap;
    
    public class Ricochet extends Entity {
        
        [Embed(source = 'assets/navPoint.png')]
        private static const RICOCHET_IMAGE:Class;
        
        private var _gfx:Spritemap;
        private var _collided:Boolean;
        
        public function Ricochet() {
            super();
            
            _gfx = new Spritemap(RICOCHET_IMAGE, 48, 48);
            _gfx.centerOrigin();
            _gfx.add("ricochet", [0, 0, 0, 0, 0], 0.6, false);
            _gfx.callback = destroy;
            graphic = _gfx;
            
            setHitbox(96, 48, 48, 24);
            type = "ricochet";
        }
        
        public function destroy():void {
            world.recycle(this);
        }
        
        override public function added():void {
            _collided = false;
            _gfx.play("ricochet", true);
        }
    }
}