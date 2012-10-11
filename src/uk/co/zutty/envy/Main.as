package uk.co.zutty.envy
{
    import net.flashpunk.Engine;
    import net.flashpunk.FP;
    
    import uk.co.zutty.envy.path.Pathfinder;
    
    public class Main extends Engine {
        public function Main() {
            super(640, 480, 60, true);
            
            FP.console.enable();
            FP.console.debug = true;
            
            FP.world = new GameWorld();
        }
    } 
} 