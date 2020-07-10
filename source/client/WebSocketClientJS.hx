package client;

import common.PointArray;
import haxe.Serializer;
import haxe.Unserializer;
import haxe.io.Bytes;
import haxe.net.WebSocket;
import js.Browser;

class WebSocketClientJS
{
	private var _host:String;
	private var _port:Int;
	private var _ws:WebSocket;
	private var _id:String;
	private var _msg_prefix:String;

	// static public function main()
	// {
	// 	var button = Browser.document.createButtonElement();
	// 	button.textContent = "Click me!";
	// 	button.onclick = function(event)
	// 	{
	// 		var ws = new WebSocketClientJS('localhost', 8008);
	// 	}
	// 	Browser.document.body.appendChild(button);
	// }

	public function new(host:String, port:Int)
	{
		_host = host;
		_port = port;
		_msg_prefix = 'chandler';
	}

	public function create():Void
	{
		var addr = 'ws://$_host:$_port/';
		_ws = WebSocket.create(addr, ['echo-protocol'], false);
		_ws.onopen = onopen;
		_ws.onmessageString = onmessageString;

		#if sys
		while (true)
		{
			_ws.process();
			Sys.sleep(0.1);
		}
		#end
	}

	function onopen()
	{
		var s = 'hello friend!';
		_ws.sendString(s);
		_ws.sendString('message was length=${s.length}');
		// need to add client ID to message prefix eventually
		_msg_prefix += ":";
	}

	function onmessageString(message:String):Void
	{
		log('message from server=' + (message.length > 200 ? message.substr(0, 200) + '...' : message));
		log('message.length=' + message.length);
	}

	function log(message:String):Void
	{
		trace('$_msg_prefix$message');
	}

	public function send_message():Void
	{
		var points = new PointArray();
		trace(points.toString());
		// serialize points before sending
		var s = Serializer.run(points);
		trace('serialized: $s');
		trace('Sending: $s');
		_ws.sendString(s);
	}
}
