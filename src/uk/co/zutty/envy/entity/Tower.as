package uk.co.zutty.envy.entity
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Tween;
	
	import uk.co.zutty.envy.RotatedSpritemap;
	
	public class Tower extends Entity {
		
		protected var _gfx:RotatedSpritemap;
		protected var _fireInterval:uint
		protected var _range:Number;
        protected var _activated:Boolean;
		private var _time:uint = 0;
		
		public function Tower(img:Class, fireInterval:uint, range:uint) {
			super();

			_gfx = new RotatedSpritemap(img, 48, 64, 32);
			_gfx.y = -16;
			graphic = _gfx;
			
			_gfx.addRotated("turn", [0], 0, false);
			
			_fireInterval = fireInterval;
			_range = range;
			
			setHitbox(48, 48, 0, 0);
			type = "building";
		}
        
        override public function added():void {
            _activated = true;
        }
        
        public function set activated(f:Boolean):void {
            _activated = f;
        }
		
		public function fire(target:Entity):void {}

		override public function update():void {
			super.update();
			
			_time++;
			
			var target:Entity = world.nearestToEntity("creep", this);
			
			if(_activated && target != null && distanceFrom(target, true) <= _range) {
				var cx:Number = x + (width/2);
				var cy:Number = y + (height/2);
				var dx:Number = cx - target.x;
				var dy:Number = cy - target.y;
				_gfx.frameAngle = (Math.atan2(dx, dy) * 180/Math.PI);
				
				if(_time > _fireInterval) {
					_time = 0;
					fire(target);
				}
			}
		}
	}
}