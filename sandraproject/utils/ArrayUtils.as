package com.sandraproject.utils{
	
	public class ArrayUtils {

		public function ArrayUtils() {
			// constructor code
		}
		
		public function getUniqueArray(subject:Array):Array{
			var total:Number = subject.length;
			var newArray:Array = new Array();
			for (var i:int=0; i<total; i++){
				if (!proccessArray(subject[i],newArray)){
					newArray.push(subject[i]);
				}
			}
			return newArray;
		}
		
		public function proccessArray(needle, subject:Array):Boolean{
		   for (var i in subject){
			  if (subject[i]==needle){
				 return true;
			  }
		   }
		   return false;
		}

	}
	
}
