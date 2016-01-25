package com.sandraproject.business{
	
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	import fl.events.ComponentEvent;
	import com.adobe.serialization.json.JSON;
	import com.sandraproject.advicer.SPAdvicer;
	import com.sandraproject.interfaces.IModel;
	import com.sandraproject.vo.DepartamentoVo;
	
	public class GeoBusiness extends EventDispatcher implements IModel{
		
		public var a_sp_advicer:SPAdvicer=SPAdvicer.getInstance();
		public var a_local_reader:CSVReader;
		public var a_departamentos:DataProvider;
		public var a_ciudades:DataProvider;
		public var a_sucursales:DataProvider;
		public var a_vitrinas:DataProvider;
		
		private var a_centinela:Boolean=false;
		
		public function GeoBusiness(_centinela:Boolean) {
			a_centinela=_centinela;
			if(a_centinela==true){
				a_local_reader=new CSVReader(a_sp_advicer.a_local_geo_path+"municipios.csv");
				addListeners();	
			}
		}				
		public function addListeners(){
			a_sp_advicer.addEventListener(a_sp_advicer.CSV_LOADED_SUCCESS, csvLoaded);
		}
		public function getLocalDepartamentos():void{
		}
		public function getDepartamentos():void{
			if(a_centinela==false){
				var _loader:URLLoader=new URLLoader();
				_loader.addEventListener(Event.COMPLETE, loadDepartamentosComplete);
				_loader.load(new URLRequest(a_sp_advicer.a_geo_path+"CtrlGVAjax?sCodPage=33"));
			}
		}
		public function getCiudades(_depa:String):void{
			if(a_centinela==false){
				var _loader:URLLoader=new URLLoader();
				_loader.addEventListener(Event.COMPLETE, loadCiudadesComplete);
				_loader.load(new URLRequest(a_sp_advicer.a_geo_path+"CtrlGVAjax?sCodPage=34&sDpto="+_depa));
			}else{
				
				a_ciudades=new DataProvider(a_departamentos.getItemAt(a_sp_advicer.a_selected_departamento).a_municipios);
				a_sp_advicer.dispatchAdvice(a_sp_advicer.CIU_COMPLETE_ADVICE);
			}
		}
		public function getSucursales():void{
			var _loader:URLLoader=new URLLoader();
			_loader.addEventListener(Event.COMPLETE, loadSucursalesComplete);
			_loader.load(new URLRequest(a_sp_advicer.a_geo_path+"CtrlGVAjax?sCodPage=15&sUN=V"));
		}
		public function getVitrinas(_sucu:int):void{
			var _loader:URLLoader=new URLLoader();
			_loader.addEventListener(Event.COMPLETE, loadVitrinasComplete);
			_loader.load(new URLRequest(a_sp_advicer.a_geo_path+"CtrlGVAjax?sCodPage=16"+"&sSucu="+_sucu+"&sUN=V"));
		}
		public function validateId(_id:String):void{
			var _loader:URLLoader=new URLLoader();
			_loader.addEventListener(Event.COMPLETE, validationComplete);
			_loader.load(new URLRequest(a_sp_advicer.a_geo_path+"CtrlPreventa?iOpc=4&sId="+_id));
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function validationComplete(e:Event):void{
			var _data=String(e.currentTarget.data);
			var _response:Object=JSON.decode(_data).success;
			trace(_response);
			if(_response==true){
				a_sp_advicer.dispatchAdvice(a_sp_advicer.ID_VALIDATION_SUCCESS_ADVICE);
			}else{
				a_sp_advicer.dispatchAdvice(a_sp_advicer.ID_VALIDATION_FAULT_ADVICE);
			}
		}
		private function loadDepartamentosComplete(e:Event):void{
			var _data=String(e.currentTarget.data);
			a_departamentos=new DataProvider(JSON.decode(_data).dpto);
			a_sp_advicer.dispatchAdvice(a_sp_advicer.DEPA_COMPLETE_ADVICE);
		}
		private function loadCiudadesComplete(e:Event):void{
			var _data=String(e.currentTarget.data);
			a_ciudades=new DataProvider(JSON.decode(_data).ciudades);
			a_sp_advicer.dispatchAdvice(a_sp_advicer.CIU_COMPLETE_ADVICE);
		}
		private function loadSucursalesComplete(e:Event):void{
			var _data=String(e.currentTarget.data);
			a_sucursales=new DataProvider(JSON.decode(_data).sucuEnt);
			a_sp_advicer.dispatchAdvice(a_sp_advicer.SUCU_COMPLETE_ADVICE);
		}
		private function loadVitrinasComplete(e:Event):void{
			var _data=String(e.currentTarget.data);
			a_vitrinas=new DataProvider(JSON.decode(_data).vitriEnt);
			a_sp_advicer.dispatchAdvice(a_sp_advicer.VITRINAS_COMPLETE_ADVICE);
		}
		private function csvLoaded(e:Event):void{
			var _temp:Array=new Array();
			var _deptos:Array=new Array();
			for(var i:int=0;i<a_local_reader.getData().length;i++){
				_temp.push(String(a_local_reader.getData()[i][0]).split("'").join(""));
			}
			_temp=arrayUnique(_temp);
			for(var j:int=0;j<_temp.length;j++){
				var _item:DepartamentoVo=new DepartamentoVo(_temp[j]);
				for(var k:int=0;k<a_local_reader.getData().length;k++){
					if(_temp[j]==String(a_local_reader.getData()[k][0]).split("'").join("")){
						var _ciudad:Object=new Object();
						_ciudad.de_ciud=String(a_local_reader.getData()[k][1]).split("'").join("");
						_item.a_municipios.push(_ciudad);
					}
				}
				_deptos.push(_item);
			}
			a_departamentos=new DataProvider(_deptos);
			a_sp_advicer.dispatchAdvice(a_sp_advicer.DEPA_COMPLETE_ADVICE);
		}
		
		private function arrayUnique(subject:Array){
		   var total:Number = subject.length;
		   var newArray:Array = new Array();
		   for (var i:int =0; i<total; i++){
			  if (!inArray(subject[i],newArray)){
				 newArray.push(subject[i]);
			  }
		   }
		   return newArray;
		}
		private function inArray(needle, subject:Array):Boolean{
		   for (var i in subject){
			  if (subject[i]==needle){
				 return true;
			  }
		   }
		   return false;
		}
	}
	
}
