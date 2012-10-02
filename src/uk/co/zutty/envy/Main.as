package uk.co.zutty.envy
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	import uk.co.zutty.envy.path.Pathfinder;
	
	[SWF(width="640", height="480", backgroundColor="#000000", frameRate="60")]
	public class Main extends Engine {
        
        private static var _pathfinder:Pathfinder = new Pathfinder(); 
        
        public static function get pathfinder():Pathfinder {
            return _pathfinder;
        }
		
		public function Main() {
			super(640, 480, 60, true);
            FP.console.enable();
            FP.console.debug = true;
			FP.world = new GameWorld();
		}
	} 
} 