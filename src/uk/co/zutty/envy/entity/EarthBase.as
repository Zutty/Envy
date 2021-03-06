package uk.co.zutty.envy.entity
{
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Image;
    
    public class EarthBase extends Hurtable {
        
        [Embed(source = 'assets/earth_base.png')]
        private const BASE_IMAGE:Class;
        
        private var _gfx:Image;
        
        public function EarthBase() {
            super();
            _gfx = new Image(BASE_IMAGE);
            graphic = _gfx;
            maxHealth = 12;
            
            type = "building";
            setHitbox(96, 96, 0, 0);
        }
    }
}