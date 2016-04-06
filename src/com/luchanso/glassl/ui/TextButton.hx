package com.luchanso.glassl.ui;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;

/**
 * ...
 * @author Loutchansky Oleg
 */
class TextButton extends Sprite
{
	var _color : Int = 0x80D8FF;
	
	static var lableMargin : Float = 10;
	
	public var lable : TextField;
	public var text(get, set) : String;
	public var color(get, set) : Int;

	public function new() 
	{
		super();
		
		addLable();
	}
	
	function drawBackroung() 
	{
		graphics.clear();
		graphics.beginFill(color);
		graphics.drawRoundRect(0, 0, lable.width + lableMargin * 2, lable.height + lableMargin * 2, 15, 15);
		graphics.endFill();
	}
	
	function addLable() 
	{
		lable = new TextField();
		lable.defaultTextFormat = new TextFormat("Arial", 14, 0xFFFFFF, true);
		lable.selectable = false;
		lable.mouseEnabled = false;
		lable.autoSize = TextFieldAutoSize.LEFT;
		lable.x = lableMargin;
		lable.y = lableMargin;
		
		addChild(lable);
	}
	
	function get_text():String 
	{
		return lable.text;
	}
	
	function set_text(value:String):String 
	{
		lable.text = value;
		
		drawBackroung();
		
		return lable.text;
	}
	
	function get_color():Int 
	{
		return _color;
	}
	
	function set_color(value:Int):Int 
	{
		_color = value;
		
		drawBackroung();
		
		return _color;
	}
	
}