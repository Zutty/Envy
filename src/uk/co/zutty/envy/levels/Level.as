package uk.co.zutty.envy.levels
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;

	public interface Level {
        function get width():Number;
        function get height():Number;
        function getLayer(name:String, solid:Boolean = false):Layer;
        function getMask(name:String):Entity;
        function getObjectPositions(layerName:String, objName:String):Vector.<Point>;
        function getNavGraph(name:String):NavGraph;
	}
}