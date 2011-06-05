package uk.co.zutty.envy
{
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class Thing extends EnvyEntity {
		
		private var _health:Number;
		private var _dead:Boolean;

		public function Thing(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) {
			super(x, y, graphic, mask);
			_health = 0;
			_dead = false;
		}
		
		public function destroy():void {
			_dead = true;
			_health = 0;
			FP.world.remove(this);
		}

		public function get dead():Boolean {
			return _dead;
		}
		
		public function set dead(d:Boolean):void {
			_dead = d;
		}

		public function get health():Number {
			return _health;
		}

		public function set health(h:Number):void {
			_health = h;
		}

		public function hurt():void {
			_health--;
			if(_health <= 0) {
				destroy();
			}
		}
		
	}
}