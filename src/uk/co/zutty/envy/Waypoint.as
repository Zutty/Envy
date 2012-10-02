package uk.co.zutty.envy
{
	public class Waypoint {
		
		private var _x:Number;
		private var _y:Number;
		private var _next:Waypoint;
		
		public function Waypoint(x:Number, y:Number, next:Waypoint = null) {
			_x = x;
			_y = y;
			_next = next;
		}
		
		public function get x():Number {
			return _x;
		}

		public function get y():Number {
			return _y;
		}
		
		public function get next():Waypoint {
			return _next;
		}

		public function set next(n:Waypoint):void {
			_next = n;
		}
	}
}