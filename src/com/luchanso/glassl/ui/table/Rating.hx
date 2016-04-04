package com.luchanso.glassl.ui.table;

import com.luchanso.tools.Copy;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.PixelSnapping;
import openfl.display.Sprite;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Rating extends Sprite
{
	var rows : List<Row>;
	var tableWidth : Float;
	var tableHeight : Float;

	public function new(tableWidth : Float, tableHeight : Float) 
	{
		super();
		
		this.tableWidth = tableWidth;
		this.tableHeight = tableHeight;
		
		rows = new List<Row>();
		
		test();
	}
	
	function test()
	{
		var test = Assets.getBitmapData("img/camera_c.gif");
		
		addScoreRow(1, new Bitmap(test, PixelSnapping.AUTO, true), "Петров Петрович", 9999);
		addScoreRow(2, new Bitmap(test, PixelSnapping.AUTO, true), "Лучанский Олег", 3193);
		addScoreRow(3, new Bitmap(test, PixelSnapping.AUTO, true), "Павел Дуров", 392);
		addScoreRow(4, new Bitmap(test, PixelSnapping.AUTO, true), "asdf asdf asdf", 32);
		addScoreRow(5, new Bitmap(test, PixelSnapping.AUTO, true), "Джеральд Хьюберт Ирвин Джон Кеннет Ллойд Мартин Неро Оливер Конец", 2);
		addScoreRow(6, new Bitmap(test, PixelSnapping.AUTO, true), "☭ ☢ ✓ ★ ♞ ₽ ‏  ‏ϖ‏", 2);
		addScoreRow(7, new Bitmap(test, PixelSnapping.AUTO, true), "☭ ☢ ✓ ★ ♞‏ Hello wor‏ld ‏", 2);
		addScoreRow(5, new Bitmap(test, PixelSnapping.AUTO, true), "Джеральд Хьюберт Ирвин Джон Кеннет Ллойд Мартин Неро Оливер Джеральд Хьюберт Ирвин Джон Кеннет Ллойд Мартин Неро Оливер Конец", 2);
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
}