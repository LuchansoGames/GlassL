package com.luchanso.glassl.effects;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.Event;

/**
 * ...
 * @author Loutchansky Oleg
 */
class CircleTween
{
	public static var cirlces : List<Circle> = new List<Circle>();

	public static function generate(stage : Sprite, x : Float, y : Float) : Circle
	{
		var circle = new Circle(x, y);
		
		circle.addEventListener(Event.REMOVED, clearMemory);
		cirlces.push(circle);
		stage.addChildAt(circle, 0);
		
		return circle;
	}
	
	private static function clearMemory(e:Event):Void 
	{
		cirlces.remove(e.target);
	}
	
}