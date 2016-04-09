package com.luchanso.glassl.ui;

import motion.Actuate;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;

/**
 * ...
 * @author Loutchansky Oleg
 */
class TextButton extends Sprite
{
	var _color : Int = 0x5BCEFF;
	var _hoverColor : Int = 0x3EC5FF;
	
	static var lableMargin : Float = 10;
	
	public var lable : TextField;
	public var text(get, set) : String;
	public var color(get, set) : Int;
	public var hoverColor(get, set) : Int;

	public function new() 
	{
		super();
		
		this.buttonMode = true;
		
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		addLable();
	}
	
	private function addedToStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		this.addEventListener(MouseEvent.MOUSE_OVER, hover);
		this.addEventListener(MouseEvent.MOUSE_OUT, unhover);
	}
	
	private function unhover(e:MouseEvent):Void 
	{
		drawBackground();
	}
	
	private function hover(e:MouseEvent):Void 
	{
		var isHover = true;
		drawBackground(isHover);
	}
	
	function drawBackground(isHover : Bool = false) 
	{
		graphics.clear();
		
		var drawColor = isHover ? hoverColor : color; 
		
		graphics.beginFill(drawColor);
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
		
		drawBackground();
		
		return lable.text;
	}
	
	function get_color():Int 
	{
		return _color;
	}
	
	function set_color(value:Int):Int 
	{
		_color = value;
		
		drawBackground();
		
		return _color;
	}
	
	function get_hoverColor():Int 
	{
		return _hoverColor;
	}
	
	function set_hoverColor(value:Int):Int 
	{
		_hoverColor = value;
		
		drawBackground();
		
		return _hoverColor;
	}	
}