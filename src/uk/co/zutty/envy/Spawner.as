package uk.co.zutty.envy
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;

	public class Spawner extends Thing {
		
		private const SPAWN_TIME:uint = 60;

		[Embed(source = '/data/pop2.mp3')]
		private const POP_SOUND:Class;

		[Embed(source = '/data/spawner.png')]
		private const SPAWNER_IMAGE:Class;
		
		private var rate:Number;
		private var spritemap:Spritemap;
		private var pop:Sfx;
		private var time:uint;
		private var lastSpawned:uint;
		
		public function Spawner() {
			super();
			spritemap = new Spritemap(SPAWNER_IMAGE, 48, 48);
			spritemap.add("spin", [0, 1, 2, 3, 4, 5, 6, 7], 0.6, true);
			spritemap.play("spin");
			graphic = spritemap;
			setHitbox(48, 48);
			
			pop = new Sfx(POP_SOUND);

			rate = 3;
			health = 3;
			time = 0;
		}
		
		public function spawnCreep():void {
			lastSpawned = time;
			var creep:Creep = new Creep();
			gameworld.creeps.push(creep);
			creep.x = x - (creep.width - width) / 2;
			creep.y = y - (creep.height - height) / 2;
			gameworld.add(creep);
			creep.onSpawn(function():void{
				pop.play();
			});
			creep.goTo(gameworld.nearestWaypoint(x, y));			
		}
		
		override public function update():void {
			time++;
			super.update();
			if(time > lastSpawned + SPAWN_TIME) {
				spawnCreep();
			}
		}
	}
}