package client;

import client.WebSocketClientJS;
import common.ParamServer;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * @author .:BuzzJeux:.
 */
class PlayState extends FlxState
{
	public var player:Player;

	var _level:TiledLevel;
	var _howto:FlxText;
	var _testbutton:FlxButton;
	var _ws_socket:WebSocketClientJS;
	var _param_server:ParamServer;

	override public function create():Void
	{
		_param_server = new ParamServer();
		_ws_socket = new WebSocketClientJS(_param_server.host, _param_server.port);
		_ws_socket.create();
		FlxG.mouse.visible = true;
		FlxG.mouse.useSystemCursor = true;
		bgColor = 0xFF18A068;

		// Load the level's tilemaps
		_level = new TiledLevel("assets/data/map.tmx");

		// Add tilemaps
		add(_level.backgroundTiles);

		// Add tilemaps
		add(_level.foregroundTiles);

		// Load player and objects of the Tiled map
		_level.loadObjects(this);

		#if !mobile
		// var message_onclick = _ws_socket.send_message.bind()
		_testbutton = new FlxButton(0, 225, "Send message", _ws_socket.send_message);
		add(_testbutton);
		#end
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// Collide with foreground tile layer
		if (_level.collideWithLevel(player))
		{
			// Resetting the movement flag if the player hits the wall
			// is crucial, otherwise you can get stuck in the wall
			player.moveToNextTile = false;
		}
	}

	override public function destroy():Void
	{
		super.destroy();

		player = null;
		_level = null;
		_howto = null;
	}
}
