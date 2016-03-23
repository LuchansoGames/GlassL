package src.com.luchanso.glassl;

import openfl.display.Sprite;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Ball extends Sprite
{
	public static var radius : Float = 12;
	
	private var _angle : Float = 0;
	private var _speed : Float = 0;
	
	public var angle(get, set) : Float;
	public var speed(get, set) : Float;
	public var speedX : Float = 0;
	public var speedY : Float = 0;
	

	public function new() 
	{
		super();
		draw();
	}
	
	private function draw() 
	{
		graphics.beginFill(0xFFFFFF);
		graphics.drawCircle(0, 0, radius);
		graphics.endFill();
	}
	
	public function update(delta : Float)
	{
		this.x += speedX * delta * speed;
		this.y += speedY * delta * speed;
	}
	
	function get_angle():Float 
	{
		return _angle;
	}
	
	function set_angle(value:Float):Float 
	{	
		_angle = value;
		
		this.speedX = Math.cos(_angle) * this.speed;
		this.speedY = Math.sin(_angle) * this.speed;
		
		return _angle;
	}
	
	function get_speed():Float 
	{
		return _speed;
	}
	
	function set_speed(value:Float):Float 
	{
		_speed = value;
		
		this.speedX = Math.cos(angle) * this.speed;
		this.speedY = Math.sin(angle) * this.speed;
		
		return _speed;
	}
	
}