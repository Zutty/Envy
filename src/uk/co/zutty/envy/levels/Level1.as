package uk.co.zutty.envy.levels
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Emitter;
	
	public class Level1 extends OgmoLevel {
		
		[Embed(source = 'assets/level1.oel', mimeType = 'application/octet-stream')]
		private const LEVEL1_OEL:Class;

		[Embed(source = 'assets/terrain.png')]
		private const TERRAIN_IMAGE:Class;

		[Embed(source = 'assets/roads.png')]
		private const ROADS_IMAGE:Class;

		public function Level1() {
			super(LEVEL1_OEL, {ground: TERRAIN_IMAGE, roads:ROADS_IMAGE}, 48, 48);
		}
	}
}