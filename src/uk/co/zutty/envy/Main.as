package uk.co.zutty.envy
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	
	[SWF(width="640", height="480", backgroundColor="#000000", frameRate="60")]
	public class Main extends Engine {
		
		public function Main() {
			super(640, 480, 60, true);
            FP.console.enable();
            FP.console.debug = true;
			FP.world = new GameWorld();
		}
	} 
} 