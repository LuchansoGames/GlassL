package com.luchanso.glassl.ui;

import com.luchanso.tools.Numerals;
import flash.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;

/**
 * ...
 * @author Loutchansky Oleg
 */
class MoneyLable extends TextField
{
	var _money = 0;
	
	public var money(get, set) : Int;

	public function new(color : Int = 0xFFFFFF)
	{
		super();
		
		this.defaultTextFormat = new TextFormat("Arial", 18, color);
		this.autoSize = TextFieldAutoSize.LEFT;
		this.mouseEnabled = false;
		this.selectable = true;
		this.text = "0 монеток";
	}
	
	function get_money():Int
	{
		return _money;
	}
	
	function set_money(value:Int):Int 
	{		
		this.text = Std.string(value) + Number.numerals(value, " монетка", " монетки", " монеток");
		
		return _money = value;
	}
	
}