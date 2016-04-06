package com.luchanso.glassl.ui.table;

import com.luchanso.tools.Copy;
import motion.Actuate;
import motion.easing.Linear;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.PixelSnapping;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Rating extends Sprite
{
	var rows : List<Row>;
	var tableWidth : Float;
	var tableHeight : Float;
	var protoY(get, set) : Float;

	public function new(tableWidth : Float, tableHeight : Float) 
	{
		super();
		
		this.tableWidth = tableWidth;
		this.tableHeight = tableHeight;		
		this.scrollRect = new Rectangle(0, 0, tableWidth, tableHeight);
		
		rows = new List<Row>();
		
		test();
		
		if (this.height > tableHeight) 
		{
			addScrollAnimation();
		}
	}
	
	function test(_ = null)
	{
		var test = Assets.getBitmapData("img/camera_c.gif");
		
		addScoreRow(1, new Bitmap(test, PixelSnapping.AUTO, true), "Петров Петрович", 9999);
		addScoreRow(2, new Bitmap(test, PixelSnapping.AUTO, true), "Лучанский Олег", 3193);
		addScoreRow(3, new Bitmap(test, PixelSnapping.AUTO, true), "Павел Дуров", 392);
		addScoreRow(4, new Bitmap(test, PixelSnapping.AUTO, true), "asdf asdf asdf", 32);
		addScoreRow(5, new Bitmap(test, PixelSnapping.AUTO, true), "Джеральд Хьюберт Ирвин Джон Кеннет Ллойд Мартин Неро Оливер Конец", 2);
		addScoreRow(6, new Bitmap(test, PixelSnapping.AUTO, true), "☭ ☢ ✓ ★ ♞ ₽ ‏  ‏ϖ‏", 2);
		addScoreRow(7, new Bitmap(test, PixelSnapping.AUTO, true), "☭ ☢ ✓ ★ ♞‏ Hello wor‏ld ‏", 2);
		addScoreRow(0, new Bitmap(test, PixelSnapping.AUTO, true), "Last", 0);
	}
	
	function addScrollAnimation() : Void
	{
		var scrollSpeed : Float = 50;
		var time : Float = (height - tableHeight) / scrollSpeed;
		
		trace(height - tableHeight);

		Actuate.tween(this, time, { protoY: height - tableHeight + Row.heightRow / 2} ).ease(Linear.easeNone);
	}
	
	public function addScoreRow(position : Int, avatar : Bitmap, name : String, score : Int)
	{
		var row = new Row(position, avatar, name, score, tableWidth);
		
		row.y = rows.length * Row.heightRow;
		
		rows.add(row);				
		addChild(row);
	}
	
	public function clearRating() : Void
	{
		
	}
	
	public function addUserScore(position : Int, avatar : Bitmap, name : String, score : Int)
	{
		
	}
	
	public function changeUserScore(position : Int, score : Int)
	{
		
	}
	
	function get_protoY():Float 
	{
		return this.scrollRect.y;
	}
	
	function set_protoY(value:Float):Float 
	{
		trace(value);
		
		this.scrollRect = new Rectangle(this.scrollRect.x, value, this.scrollRect.width, this.scrollRect.height);
		
		return value;
	}
}