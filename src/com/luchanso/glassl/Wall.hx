package src.com.luchanso.glassl;

import com.luchanso.glassl.Config;
import openfl.display.Sprite;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Wall extends Sprite
{
	public function new(x, y, width, height) 
	{
		super();
		
		this.x = x;
		this.y = y;
		
		draw(width, height);
	}
	
	private function draw(width : Float, height : Float) : Void
	{
		graphics.beginFill(Config.colorLight);
		graphics.drawRect(0, 0, width, height);
		graphics.endFill();
	}
}