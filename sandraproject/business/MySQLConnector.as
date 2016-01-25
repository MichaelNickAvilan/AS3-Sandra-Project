package com.sandraproject.business{
	
	import flash.net.LocalConnection;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import com.siete.pipasa.model.ModelLocator;
	import com.sandraproject.interfaces.IModel;
	import flash.events.NetStatusEvent;
	
	public class MySQLConnector implements IModel{
		
		public var a_model:ModelLocator=ModelLocator.getInstance();
		private var lc:LocalConnection;
		private var a_maker:NetConnection;
		private var a_gateway:String;
		
		public function MySQLConnector() {
			addListeners();
		}
		public function addListeners(){
			
		}
		public function setGateway(_maker:NetConnection,_gateway:String):void{
			a_maker=_maker;
			a_gateway=_gateway;
			makeConnection();
		}
		public function makeConnection():void{
			a_maker.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			lc = new LocalConnection();
			lc.allowDomain(a_gateway);
			a_maker.objectEncoding = ObjectEncoding.AMF0;
			a_maker.connect(a_gateway);
			a_model.dispatchAdvice(a_model.DB_CONNECTED_EVENT);
		}
		private function netStatusHandler(event:NetStatusEvent):void {
			trace(event.info.code);
			switch (event.info.code) {
				case "NetConnection.Connect.Failed":
					a_model.dispatchAdvice(a_model.DB_CONNECTION_FAIL_EVENT);
					break;
				case "NetConnection.Connect.Closed":
					a_model.dispatchAdvice(a_model.DB_CONNECTION_FAIL_EVENT);
					break;
				case "NetConnection.Call.Failed":
					a_model.dispatchAdvice(a_model.DB_CONNECTION_FAIL_EVENT);
					break;
			}
		}
	}

}
