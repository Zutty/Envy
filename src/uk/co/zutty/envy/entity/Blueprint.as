package uk.co.zutty.envy.entity
{
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Spritemap;
    
    public class Blueprint extends EnvyEntity {
        
        [Embed(source = 'assets/spawner_blueprint.png')]
        private static const BLUEPRINT_IMAGE:Class;
        
        private var _gfx:Spritemap;
        
        public function Blueprint() {
            super();
            
            _gfx = new Spritemap(BLUEPRINT_IMAGE, 48, 48);
            _gfx.add("yes", [0], 0, false);
            _gfx.add("no", [1], 0, false);
            _gfx.alpha = 0.6;
            graphic = _gfx;
            
            setHitbox(48, 48, 0, 0);
        }
        
        public function set buildable(b:Boolean):void {
            _gfx.play(b ? "yes" : "no");
        }
        
        public function get buildable():Boolean {
            return _gfx.currentAnim == "yes";
        }
        
        override public function update():void {
            super.update();
            
            buildable = collide("building", x, y) == null;
        }
    }
}