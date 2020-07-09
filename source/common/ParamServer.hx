package common;

// this class provides common configuration data between the client and the server
// Each will instantiate a ParamServer object, and use its members to connect
class ParamServer
{
	public var host:String = 'localhost';
	public var port:Int = 8008;

	public function new() {}
}
