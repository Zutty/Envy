package uk.co.zutty.envy
{
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class EarthBase extends Thing {
		
		[Embed(source = 'assets/earth_base.png')]
		private const BASE_IMAGE:Class;
		
		public function EarthBase() {
			super();
			graphic = new Image(BASE_IMAGE);
			health = 12;
		}
	}
}