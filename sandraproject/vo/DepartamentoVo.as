/**
 * @author Michael Nick Avilan Mora
 * @since 1.0
 */
package com.sandraproject.vo{
	
	public class DepartamentoVo {
		
		public var icon;
		public var de_dpto:String;
		public var a_municipios:Array=new Array();

		public function DepartamentoVo(_departamento:String) {
			de_dpto=_departamento;
		}

	}
	
}
