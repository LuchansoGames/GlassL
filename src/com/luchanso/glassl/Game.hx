package com.luchanso.glassl;

import flash.events.Event;
import motion.Actuate;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.events.TimerEvent;
import openfl.media.Sound;
import openfl.ui.Keyboard;
import openfl.utils.Timer;
import src.com.luchanso.glassl.Ball;
import src.com.luchanso.glassl.Wall;

/**
 * ...
 * @author Loutchansky Oleg
 */
class Game extends Sprite 
{	
	var ball : Ball;
	
	var wallTop : Wall;
	var wallLeft : Wall;
	var wallRight : Wall;
	var wallBottom : DynamicWall;
	var score : Score;
	var accelerateTimer : Timer;
	var sound : Sound;
	var soundButton : SoundButton;
	
	var timestep : Timestep;
	
	static var diametr : Float = 20;
	static var margin : Float = 50;
	static var widthWall : Float = 450;
	static var heightWall : Float = Config.height - (margin * 2 + diametr);

	public function new(soundButton : SoundButton)
	{
		super();
		
		this.soundButton = soundButton;
		
		timestep = new Timestep();
		timestep.gameSpeed = 0.65;
		
		wallTop = new Wall(Config.width / 2 - widthWall / 2, margin, widthWall, diametr);
		wallLeft = new Wall(Config.width / 2 - widthWall / 2 - diametr, margin, diametr, heightWall);
		wallRight = new Wall(Config.width / 2 - widthWall / 2 + widthWall, margin, diametr, heightWall);
		wallBottom = new DynamicWall((Config.width / 2 - widthWall / 2), margin + heightWall - diametr / 2, widthWall, diametr / 2);
		
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
	}
	
	private function accelrateGame(e:TimerEvent):Void 
	{
		ball.speed += 0.01;
	}
	
	private function update(e:Event) : Void 
	{
		timestep.tick();
		
		ball.update(timestep.timeDelta);
		calcBounce();
		PixelTween.update(timestep.timeDelta);
	}
	
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
	
	private function drawDebug() : Void
	{		
		graphics.lineStyle(1, 0xFF0000);
		graphics.moveTo(Config.width / 2, 0);
		graphics.lineTo(Config.width / 2, Config.height);
		graphics.moveTo(0, Config.height / 2);
		graphics.lineTo(Config.width, Config.height / 2);		
		
		graphics.lineStyle(1, 0x00FF00);
		graphics.moveTo(wallLeft.x + wallLeft.width, 0);
		graphics.lineTo(wallLeft.x + wallLeft.width, Config.height);
		
	}
	
	private function generateBall() : Ball
	{		
		var ball = new Ball();
		ball.angle = -Math.PI + Math.random() * Math.PI * 2;
		ball.speed = 2;
		ball.x = Config.width / 2;
		ball.y = Config.height / 2;
		
		return ball;
	}
	
	private function calcBounce()
	{		
		if (ball.y + ball.speedY * timestep.timeDelta + Ball.radius < wallBottom.y + wallBottom.height) 
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
			if (ball.y + ball.speedY * timestep.timeDelta + Ball.radius > wallBottom.y && wallBottom.isActive)
			{
				bounceBall(BouncePosition.BOTTOM);
			} 
		} 
		else if (ball.y + ball.speedY * timestep.timeDelta + Ball.radius > Config.height)
		{
			lose();
		}
	}
	
	private function bounceBall(type : BouncePosition) : Void
	{	
		score.setScore(score.getScore() + 1);
		
		if (soundButton.isStateOn) 
		{
			sound.play();
		}
		
		PixelTween.generate(this, 5, ball.x, ball.y);
		
		if (type == BouncePosition.RIGHT) 
		{
			if (ball.speedY > 0) 
			{				
				ball.angle = Math.PI / 2 + Math.random() * Math.PI / 2;
			} 
			else 
			{
				ball.angle = -Math.PI / 2 - Math.random() * Math.PI / 2;
			}
		}
		if (type == BouncePosition.LEFT) 
		{
			if (ball.speedY > 0) 
			{				
				ball.angle = Math.random() * Math.PI / 2;
			} 
			else 
			{
				ball.angle = Math.random() * -Math.PI / 2;
			}
		}
		if (type == BouncePosition.TOP) 
		{
			if (ball.speedX > 0)
			{				
				ball.angle = Math.random() * Math.PI / 2;
			} 
			else 
			{
				ball.angle = Math.PI / 2 + Math.random() * Math.PI / 2;
			}
		}
		if (type == BouncePosition.BOTTOM) 
		{
			ball.angle = Math.random() * -Math.PI;
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
		this.dispatchEvent(new Event("lose"));
	}
}
