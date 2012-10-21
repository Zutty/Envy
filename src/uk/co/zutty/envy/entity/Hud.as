package uk.co.zutty.envy.entity
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Graphiclist;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Text;
    
    public class Hud extends Entity {
        
        private var _baseHealthBar:Image;
        
        public function Hud() {
            super(0, 0);
            
            layer = -100;
            
            addGraphic(new Text("Base", 555, 10, {size: 30, align: "right"}));
            
            // the bar background
            var baseHealthBg:Image = Image.createRect(150, 12, 0x000000);
            baseHealthBg.x = 485;
            baseHealthBg.y = 5;
            addGraphic(baseHealthBg);
            
            // The bar itself
            _baseHealthBar = Image.createRect(146, 8, 0xFFFFFF);
            _baseHealthBar.x = 487;
            _baseHealthBar.y = 7;
            _baseHealthBar.clipRect.width = 48; 
            addGraphic(_baseHealthBar);

            graphic.scrollX = 0;
            graphic.scrollY = 0;
        }
        
        public function set baseHealth(v:Number):void {
            var val:Number = FP.clamp(v, 0, 1);
            _baseHealthBar.clipRect.width = v * 146;
            _baseHealthBar.updateBuffer(true);
        }
    }
}