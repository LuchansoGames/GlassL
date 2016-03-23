package com.luchanso.glassl;

import openfl.Lib;

/**
 * Class to manage time
 */
class Timestep
{
	public var gameSpeed(get, set):Float;
	public var maxSpeed	(get, set):Float;
	public var smoothing(get, set):Float;
	public var timeDelta(get, null):Float;

	var _gameSpeed			:Float = 1;
	var _targetFrametime	:Float = 0.6;
	var _maxSpeed			:Float = 3;
	var _smoothing			:Float = .5;
	
	var _realSpeed			:Float = 0.0;
	var _lastFrameTime		:Float = 0.0;
	var _delta				:Float = 0.0;

	/**
	 * Intialization timestep
	 * @param fps  			Target framerate you wish to maintain
	 * @param gameSpeed 	Game's speed, useful for slowdown effects. 1 = 100% speed.
	 * @param maxSpeed 		Max size of a timeDelta, steps will not be bigger
	 * @param smoothing 	How much to smooth the step size across ticks, 1 gives old value full priority (value will never change), 0 means no smoothing, so new value will be used.
	 */
	public function new(fps:Int = 60, gameSpeed:Float = 1.0, maxSpeed:Float = 3.0, smoothing:Float = 0.5) 
	{
		_targetFrametime = fps * 0.001;
		_smoothing = smoothing;
		this.gameSpeed = gameSpeed;
		this.maxSpeed = maxSpeed;
	}

		/**
		 * Call this function every frame to get a updated timeDelta
		 * @return	timeDelta
		 */
		public function tick():Float 
		{
			_realSpeed = (Lib.getTimer() - _lastFrameTime) / _targetFrametime;
			_lastFrameTime = Lib.getTimer();
			
			if (_realSpeed > _maxSpeed) _realSpeed = _maxSpeed;
			
			_delta -= (_delta - _realSpeed) * (1 - _smoothing);
			
			return _delta * _gameSpeed;
		}

		public function get_timeDelta():Float { return _delta * _gameSpeed; }
		
		public function get_maxSpeed():Float {	return _maxSpeed; }
		public function set_maxSpeed(value:Float):Float { return _maxSpeed = value; }
		
		public function get_gameSpeed():Float { return _gameSpeed; }
		public function set_gameSpeed(value:Float):Float { return _gameSpeed = value;	}
		
		public function get_smoothing():Float { return _smoothing; }
		public function set_smoothing(value:Float):Float {
			if (value > 1) value = 1;
			if (value < 0) value = 0;
			return _smoothing = value;
		}
}
