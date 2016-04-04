package com.luchanso.glassl.scenes;

import com.luchanso.glassl.actors.BouncePosition;
import com.luchanso.glassl.actors.DynamicWall;
import com.luchanso.glassl.effects.PixelTween;
import com.luchanso.glassl.ui.Score;
import com.luchanso.glassl.ui.SoundButton;
import flash.events.Event;
import motion.Actuate;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.events.TimerEvent;
import openfl.geom.Point;
import openfl.media.Sound;
import openfl.ui.Keyboard;
import openfl.utils.Timer;
import com.luchanso.glassl.actors.Ball;
import com.luchanso.glassl.actors.Wall;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Game extends Scene 
{
	var ball : Ball;
	
	var wallTop : Wall;
	var wallLeft : Wall;
	var wallRight : Wall;
	var wallBottom : DynamicWall;
	var score : Score;
	var accelerateTimer : Timer;
	var sound : Sound;
	
	var timestep : Timestep;
	
	static var diametr : Float = 20;
	static var margin : Float = 50;
	
	var widthWall : Float = 0;
	var heightWall : Float = 0;

	public function new()
	{
		super();
		
		widthWall = 450;
		heightWall = Lib.current.stage.window.height - (margin * 2 + diametr);
		
		timestep = new Timestep();
		timestep.gameSpeed = 0.65;
		
		wallTop = new Wall(Lib.current.stage.window.width / 2 - widthWall / 2, margin, widthWall, diametr);
		wallLeft = new Wall(Lib.current.stage.window.width / 2 - widthWall / 2 - diametr, margin, diametr, heightWall);
		wallRight = new Wall(Lib.current.stage.window.width / 2 - widthWall / 2 + widthWall, margin, diametr, heightWall);
		wallBottom = new DynamicWall((Lib.current.stage.window.width / 2 - widthWall / 2), margin + heightWall - diametr / 2, widthWall, diametr / 2);
		
		score = new Score();
		
		ball = generateBall();
		
		addChild(wallTop);
		addChild(wallLeft);
		addChild(wallRight);
		addChild(wallBottom);
		addChild(score);
		addChild(ball);
		
		sound = Assets.getSound("sound/ding.wav");
		
		this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		this.addEventListener(Event.ENTER_FRAME, update);
		
		accelerateTimer = new Timer(100);
		accelerateTimer.addEventListener(TimerEvent.TIMER, accelrateGame);
		accelerateTimer.start();
		
		#if cheat
		
		cheatActivate();
		
		#end
	}
	
	private function accelrateGame(e:TimerEvent):Void 
	{
		//ball.speed += 0.01;
		if (timestep.gameSpeed < 4) 
		{
			timestep.gameSpeed += 0.01;
		}
	}
	
	private function update(e:Event) : Void 
	{
		timestep.tick();		
		
		calcBounce();
		ball.update(timestep.timeDelta);
		PixelTween.update(timestep.timeDelta);
	}
	
	#if cheat
	
	private function cheatActivate()
	{
		wallBottom.isActive = true;
		wallBottom.isSleep = true;
		wallBottom.alpha = 1;
	}
	
	#end
	
	private function addedToStage(e:Event) : Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		this.stage.addEventListener(MouseEvent.CLICK, click);
	}
	
	private function click(e:MouseEvent):Void 
	{
		if (!wallBottom.isActive && !wallBottom.isSleep)
		{
			wallBottom.show(0.4 - accelerateTimer.currentCount * 0.001);
		}
	}
	
	private function keyDown(e:KeyboardEvent) : Void 
	{
		if (e.keyCode == Keyboard.SPACE && !wallBottom.isActive && !wallBottom.isSleep)
		{
			wallBottom.show(0.4 - accelerateTimer.currentCount * 0.001);
		}
	}
	
	private function generateBall() : Ball
	{		
		var ball = new Ball();
		ball.angle =  -(Math.PI - Math.PI * (2 / 3)) / 2 + (-Math.PI * (2 / 3) * Math.random());
		ball.speed = 2;
		ball.x = Lib.current.stage.window.width / 2;
		ball.y = Lib.current.stage.window.height / 2;
		
		return ball;
	}
	
	private function calcBounce()
	{
		var rayTraceResult = rayTrace(ball.y, ball.y + ball.speedY * timestep.timeDelta, wallBottom.y);		
		
		if (ball.y < wallBottom.y + wallBottom.height || rayTraceResult)
		{
			if (ball.x + ball.speedX * timestep.timeDelta + Ball.radius > wallRight.x)
			{
				bounceBall(BouncePosition.RIGHT);
			}
			if (ball.x + ball.speedX * timestep.timeDelta - Ball.radius < wallLeft.x + wallLeft.width) 
			{
				bounceBall(BouncePosition.LEFT);
			}
			if (ball.y + ball.speedY * timestep.timeDelta - Ball.radius < wallTop.y + wallTop.height)
			{
				bounceBall(BouncePosition.TOP);
			}
			if ((((ball.y + ball.speedY * timestep.timeDelta + Ball.radius > wallBottom.y) || (rayTraceResult))
				&& wallBottom.isActive) 
				&& ball.speedY > 0)
			{				
				score.setScore(score.getScore() + 1);
				bounceBall(BouncePosition.BOTTOM);
			} 
		} 
		else if (ball.y + ball.speedY * timestep.timeDelta - Ball.radius  > Lib.current.stage.window.height)
		{
			lose();
		}
	}
	
	private function rayTrace(pointMin : Float, pointMax : Float, staticPoint : Float) : Bool
	{
		return staticPoint >= pointMin && staticPoint <= pointMax;
	}
	
	private function bounceBall(type : BouncePosition) : Void
	{		
		if (Config.soundOn) 
		{
			sound.play();
		}
		
		PixelTween.generate(this, 3, ball.x, ball.y);
		
		if (type == BouncePosition.RIGHT) 
		{
			wallRight.bounce();
			if (ball.speedY > 0) 
			{
				ball.angle = Math.PI - ball.angle;
			} 
			else 
			{
				ball.angle = -Math.PI - ball.angle;
			}
		}
		if (type == BouncePosition.LEFT) 
		{
			wallLeft.bounce();
			if (ball.speedY > 0) 
			{				
				ball.angle = Math.PI - ball.angle;
			} 
			else 
			{
				ball.angle = -Math.PI - ball.angle;
			}
		}
		if (type == BouncePosition.TOP) 
		{
			wallTop.bounce();
			ball.angle *= -1;
		}
		if (type == BouncePosition.BOTTOM) 
		{
			ball.angle *= -1;
		}
	}
	
	private function getNoiseAngle(angle : Float, delta : Float) : Float
	{
		return (angle - delta / 2) + Math.random() * (delta / 2);
	}
	
	private function lose()
	{
		this.removeEventListener(Event.ENTER_FRAME, update);
		this.stage.removeEventListener(MouseEvent.CLICK, click);
		this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		
		var loseEvent = new GameEvent(GameEvent.LOSE);
		loseEvent.score = score.getScore();
		
		this.dispatchEvent(loseEvent);
	}
}
