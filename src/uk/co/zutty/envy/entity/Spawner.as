package uk.co.zutty.envy.entity
{
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.Sfx;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Spritemap;
    
    import uk.co.zutty.envy.GameWorld;
    import uk.co.zutty.envy.Main;
    import uk.co.zutty.envy.Waypoint;
    
    public class Spawner extends Hurtable {
        
        private const SPAWN_TIME:uint = 60;
        
        [Embed(source = 'assets/navPoint.png')]
        private const NAV_IMAGE:Class;
        
        [Embed(source = 'assets/pop2.mp3')]
        private const POP_SOUND:Class;
        
        [Embed(source = 'assets/spawner.png')]
        private const SPAWNER_IMAGE:Class;
        
        private var _rate:Number;
        private var _spritemap:Spritemap;
        private var _pop:Sfx;
        private var _time:uint;
        private var _lastSpawned:uint;
        private var _path:Waypoint;
        private var _spawn:Boolean;
        
        public function Spawner() {
            super();
            _spritemap = new Spritemap(SPAWNER_IMAGE, 48, 64);
            _spritemap.add("spin", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 0.5, true);
            _spritemap.play("spin");
            _spritemap.centerOrigin();
            graphic = _spritemap;
            
            setHitbox(48, 48, 24, 24);
            type = "building";
            
            _pop = new Sfx(POP_SOUND);
            
            _rate = 3;
            health = 3;
            _time = 0;
        }
        
        public function get path():Waypoint {
            return _path;
        }
        
        public function get spawn():Boolean {
            return _spawn;
        }
        
        public function set spawn(s:Boolean):void {
            _spawn = s;
        }
        
        override public function added():void {
            _path = (FP.world as GameWorld).getPathFrom(x, y);
            _spawn = true;
        }
        
        public function spawnCreep():void {
            _lastSpawned = _time;
            var creep:Creep = world.create(Creep) as Creep;
            creep.x = x;
            creep.y = y;
            creep.onSpawn(pop);
            creep.goTo(_path);			
        }
        
        public function pop():void {
            _pop.play();
        }
        
        override public function update():void {
            super.update();
            
            _time++;
            if(_spawn && _time > _lastSpawned + SPAWN_TIME) {
                spawnCreep();
            }
        }
    }
}