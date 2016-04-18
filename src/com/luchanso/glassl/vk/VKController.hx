package com.luchanso.glassl.vk;

import com.luchanso.tools.Numerals.Number;
import haxe.Json;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.PNGEncoderOptions;
import openfl.display.PixelSnapping;
import openfl.display.Sprite;
import openfl.filters.DropShadowFilter;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import pgr.dconsole.DC;
import vk.Vk;

/**
 * ...
 * @author Loutchansky Oleg
 */
class VKController
{
	public static var vk : Vk;
	public static var user;
	
	static var wallPostBackground : Bitmap;
	static var scoreField : TextField;
	
	public static function init() : Void 
	{
		initVK();
		initWallPost();		
	}
	
	static private function initWallPost() 
	{
		wallPostBackground = new Bitmap(Assets.getBitmapData("img/wallPost.png"), PixelSnapping.AUTO, true);
		
		scoreField = new TextField();
		scoreField.defaultTextFormat = new TextFormat("Arial", 100, 0xFFFFFF);
		scoreField.autoSize = TextFieldAutoSize.LEFT;
	}
	
	static private function initVK() 
	{
		var flashVars = Lib.current.stage.loaderInfo.parameters;
		vk = new Vk(flashVars);
		vk.setTestModeOn();
		
		if (vk.isVKEnvironment())
        {
            var paramsWindow = new Array();
            paramsWindow.push("setTitle");
            paramsWindow.push("v1.0.0");

            vk.callMethod(paramsWindow);

            vk.api("users.get", { fields: "photo_50"}, userGetComplete, userGetError);
        }
	}
	
	static private function userGetError(params : Dynamic) : Void
	{
		#if debug
		
		DC.log(params);
		
		#end
	}
	
	static private function userGetComplete(params : Dynamic) : Void
	{
		#if debug
		
		DC.log(params);
		
		#end
		
		user = params;
	}
	
	public static function paymentActivate(_ = null) : Void
	{
		if (vk.isVKEnvironment())
		{
			var paramsWindow = new Array<Dynamic>();
			
			paramsWindow.push("showOrderBox");			
			paramsWindow.push({type: "votes"});
			
			vk.callMethod(paramsWindow);
		}
	}
	
	/**
	 * Поделиться результатом на стену
	 */
	public static function publicateWallResult(score : Int)
	{
		if (vk.isVKEnvironment()) 
		{
			scoreField.text = "Я набрал " + Std.string(score) + " " + Number.numerals(score, "очко", "очка", "очков");
			scoreField.x = wallPostBackground.width / 2 - scoreField.width / 2;
			scoreField.y = wallPostBackground.height / 2 - scoreField.height / 2;
			scoreField.filters = [ new DropShadowFilter(4, 90, 0, 0.6, 2, 2, 1, 1) ];
			
			var wallSprite = new Sprite();
			wallSprite.addChild(wallPostBackground);
			wallSprite.addChild(scoreField);
			
			var wallBitmapData = new BitmapData(Std.int(wallSprite.width), Std.int(wallSprite.height));
			wallBitmapData.draw(wallSprite);
			
			var byteArray = wallBitmapData.encode(new Rectangle(0, 0, wallBitmapData.width, wallBitmapData.height), new PNGEncoderOptions(false));
			vk.uploadWallPhoto(byteArray, { }, finishUpload, error);
		}
	}
	
	static public function error(params:Dynamic) 
	{
		DC.log("----------------------------");
		DC.log(params);
	}
	
	static private function finishUpload(params:Dynamic)
	{
		params = Json.parse(params);
		
		params = {
			"photo": params.photo,
			"server": params.server,
			"hash": params.hash,
		}
		
		vk.api("photos.saveWallPhoto", params, publicOnWall, error);
	}
	
	static private function publicOnWall(params:Dynamic) 
	{
		var wallPostParams = {			
			"message": "А тебе слабо столько набрать в GlassL? https://vk.com/app5373055",
			"attachments": getPhotoID(Std.string(params)) + ",https://vk.com/app5373055"
		}
		
		vk.api("wall.post", wallPostParams, endLoadPhoto, error);
	}
	
	static private function getPhotoID (str:String):String {
		var start = str.indexOf(" id : ") + " id : ".length;
		var end = str.indexOf(" ", start);
		var temp = str.substring(start, end);
		if (temp.indexOf(",") != -1)
			temp = temp.substring(0, temp.length - 1);
		return temp;
	}
	
	static private function endLoadPhoto(params:Dynamic) 
	{
		// Пост опубликован
	}
}