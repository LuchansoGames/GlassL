package com.luchanso.glassl.actors;

import com.luchanso.glassl.Config;
import motion.Actuate;
import motion.easing.Linear;
import openfl.display.Sprite;
import openfl.filters.DropShadowFilter;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Wall extends Sprite
{
	private var _color : Int = 0;
	private var color(get, set) : Int;
	private var animationComplete : Bool = true;
	
	public function new(x, y, width, height) 
	{
		super();
		
		this.x = x;
		this.y = y;
		
		_color = Config.colorLight;
		
		draw(width, height);
	}
	
	public function bounce()
	{
		if (animationComplete)
		{
			Actuate.transform(this, 0.25).color(Config.colorBounce).ease(Linear.easeNone).reflect().reverse().onComplete(function() { 
				animationComplete = true;
			} );
		}
	}
	
	private function draw(width : Float, height : Float) : Void
	{
		graphics.clear();
		graphics.beginFill(color);
		graphics.drawRect(0, 0, width, height);
		graphics.endFill();
	}
	
	function get_color():Int 
	{
		return _color;
	}
	
	function set_color(value:Int):Int 
	{
		_color = value;
		
		draw(this.width, this.height);
		
		return _color;
	}
}