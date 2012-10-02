package uk.co.zutty.envy.levels
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;

	public class OgmoLevel implements Level {
		
        private var data:XML;
        private var tileMaps:Object;
        private var _tileWidth:Number;
        private var _tileHeight:Number;

        public function OgmoLevel(raw:Class, tileMaps:Object, tileWidth:Number, tileHeight:Number) {
            _tileWidth = tileWidth;
            _tileHeight = tileHeight;
            this.tileMaps = tileMaps;
            var bytes:ByteArray = new raw();
            data = new XML(bytes.readUTFBytes(bytes.length));
        }
        
        public function get width():Number {
            return data.width;
        }
        
        public function get height():Number {
            return data.height;
        }
        
        public function get tileWidth():Number {
            return _tileWidth;
        }
        
        public function get tileHeight():Number {
            return _tileHeight;
        }

        public function getLayer(name:String, solid:Boolean = false):Layer {
            return loadLayer(name, true, solid);
        }
        
        public function getMask(name:String):Entity {
            return loadLayer(name, false, true);
        }
        
        private function loadLayer(name:String, showTiles:Boolean, solid:Boolean):Layer {
            var layer:Layer = new Layer();
            
            if(showTiles) {
                layer.tilemap = new Tilemap(tileMaps[name] as Class, data.width, data.height, tileWidth, tileHeight);
            }
            if(solid) {
                layer.grid = new Grid(data.width, data.height, tileWidth, tileHeight);
            }
            
            for each(var tile:XML in data[name][0].tile) {
                if(showTiles) {
                    var idx:uint = layer.tilemap.getIndex(tile.@tx / tileWidth, tile.@ty / tileHeight);
                    layer.tilemap.setTile(tile.@x / tileWidth, tile.@y / tileHeight, idx);
                }
                if(solid) {
                    layer.grid.setTile(tile.@x / tileWidth, tile.@y / tileHeight);
                }
            }
            
            if(solid) {
                layer.type = (showTiles) ? "solid" : name;
            }
            
            return layer;
        }

		/*public function getObjectRoutes(layerName:String, objName:String):Vector.<Route> {
            var ret:Vector.<Route> = new Vector.<Route>();

			for each(var obj:XML in data[layerName][0][objName]) {
                var route:Route = new Route();
				for each(var node:XML in obj.node) {
                    route.addPoint(node.@x, node.@y);
				}
                ret[ret.length] = route;
			}
            
			return ret;
		}*/
		
        public function getObjectPositions(layerName:String, objName:String):Vector.<Point> {
            var ret:Vector.<Point> = new Vector.<Point>();
            for each(var obj:XML in data[layerName][0][objName]) {
                ret[ret.length] = new Point(obj.@x, obj.@y);
            }
            return ret;
        }
        
        public function getObjectPosition(layerName:String, objName:String):Point {
            var obj:XML = data[layerName][0][objName][0];
            return new Point(obj.@x, obj.@y);
        }

        public function getNavGraph(layerName:String):NavGraph {
            var graph:NavGraph = new NavGraph(width / tileWidth, height / tileHeight);
            
            for each(var tile:XML in data[layerName][0].tile) {
                graph.setNavigable(tile.@x / tileWidth, tile.@y / tileHeight);
            }
            
            return graph; 
        }
	}
}