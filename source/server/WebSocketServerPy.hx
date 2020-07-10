package server;

import common.ParamServer;
import common.PointArray.*;
import haxe.CallStack;
import haxe.Json;
import haxe.Serializer;
import haxe.Unserializer;
import haxe.io.Bytes;
import haxe.net.WebSocket;
import haxe.net.WebSocketServer;

class WebSocketServerHandler
{
	static var _nextId = 0;

	var _id = _nextId++;
	var _websocket:WebSocket;
	var _msg_prefix:String;

	public function new(websocket:WebSocket)
	{
		_msg_prefix = 'shandler$_id:';
		_websocket = websocket;
		_websocket.onopen = onopen;
		_websocket.onclose = onclose;
		_websocket.onerror = onerror;
		_websocket.onmessageBytes = onmessageBytes;
		_websocket.onmessageString = onmessageString;
	}

	public function update():Bool
	{
		_websocket.process();
		// trace('$_msg_prefix update');
		return _websocket.readyState != Closed;
	}

	function onopen():Void
	{
		log('open');
		_websocket.sendString('Hello from server');
	}

	function onerror(message:String):Void
	{
		log('error:$message');
	}

	function onmessageString(message:String):Void
	{
		log('string:$message');
		try
		{
			var points = Unserializer.run(message);
			log('points:${points.toString()}');
		}
		catch (e:Dynamic) {}
		_websocket.sendString('Server recevied message=$message');
	}

	function onmessageBytes(message:Bytes):Void
	{
		log('bytes:' + message.toHex());
		_websocket.sendBytes(message);
	}

	function onclose():Void
	{
		log('close');
	}

	function log(message:String):Void
	{
		trace('$_msg_prefix$message');
	}

	public function getID():Int
	{
		return _id;
	}
}

class WebSocketServerPy
{
	static function main()
	{
		var param_server = new ParamServer();
		var server = WebSocketServer.create(param_server.host, param_server.port, 1, true);
		var handlers = [];
		trace('listening to ${param_server.host} on port ${param_server.port}');
		while (true)
		{
			try
			{
				var websocket = server.accept();
				if (websocket != null)
				{
					var handler = new WebSocketServerHandler(websocket);
					handlers.push(handler);
					trace('Server: added client ${handler.getID()}');
				}
			}
			catch (e:Dynamic)
			{
				// no op, we will error all the time because .accept() will error if no data comes
				Sys.sleep(0.05);
			}
			try
			{
				var toRemove = [];
				for (handler in handlers)
				{
					if (!handler.update())
					{
						trace('Server: update() failed from client ${handler.getID()}');
						toRemove.push(handler);
					}
				}

				while (toRemove.length > 0)
				{
					var handler = toRemove.pop();
					trace('Server: removing ${handler.getID()}');
					handlers.remove(handler);
				}
			}
			catch (e:Dynamic)
			{
				// no op
				Sys.sleep(0.05);
				trace('Error', e);
				trace(CallStack.exceptionStack());
			}
		}
	}
}
