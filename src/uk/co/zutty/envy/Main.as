package uk.co.zutty.envy
{
    import net.flashpunk.Engine;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Text;
    
    import uk.co.zutty.envy.path.Pathfinder;
    
    public class Main extends Engine {

        [Embed(source = 'assets/fonts/FingerPaint-Regular.ttf', embedAsCFF="false", fontFamily = 'fingerpaint')]
        private static const KNEWAVE_FONT:Class;

        public function Main() {
            super(640, 480, 60, true);
            
            Text.font = "fingerpaint";

            //FP.console.enable();
            //FP.console.debug = true;
            
            FP.world = new GameWorld();
        }
    } 
} 