package world
{
	import commonInterface.IClone;
	
	import flash.sampler.getSavedThis;
	import flash.utils.Dictionary;
	
	import functionUtl.ExecFunctions;
	
	/**
	 * 业务数据抽象类
	 * @author blank
	 * 
	 */
	public class AbstractBusinessData implements IClone
	{
		/**
		 * 存储绑定函数的hash表
		 */
		public var bindingFunHashTable:Dictionary=new Dictionary();
		
		/**
		 * 添加绑定函数(只能对函数进行绑定.约定:可进行绑定的函数以set和get开头成队出现,只能对set开始的函数进行绑定)
		 * @param callbackFun 回调函数,必须接受两个参数: Function 和 * ,第一参数为被绑定的函数,第二个参数为附加函数,一般为属性改变后的值
		 * @param bindingFun 被绑定函数
		 * 
		 */
		public function addBindingFun(callbackFun:Function,bindingFun:Function):void{
			if(getSavedThis(bindingFun) == this){
				var execFuns:ExecFunctions=bindingFunHashTable[bindingFun] || (bindingFunHashTable[bindingFun]=new ExecFunctions());
				execFuns.addFunc(callbackFun);
			}else{
				throw new Error("被绑定函数必须属于此对象");
			}
		}
		
		/**
		 * 移除绑定函数
		 * @param callbackFun 回调函数
		 * @param bindingFun 被绑定函数
		 * 
		 */
		public function rmBindingFun(callbackFun:Function,bindingFun:Function):void{
			var execFuns:ExecFunctions=bindingFunHashTable[bindingFun];
			if(execFuns){
				execFuns.removeFunc(callbackFun);
				if(execFuns.numFunc < 1){
					delete bindingFunHashTable[bindingFun];
				}
			}
		}
		
		/**
		 * 执行回调函数
		 * @param bindingFun 被绑定函数
		 * @param additionalData 附加数据
		 * 
		 */
		protected function execCallbackFun(bindingFun:Function,additionalData:*=null):void{
			var execFuns:ExecFunctions=bindingFunHashTable[bindingFun];
			if(execFuns){
				execFuns.exec_appointedArgs([bindingFun,additionalData]);
			}
		}
		
		public function clone():*{
			return new AbstractBusinessData();
		}
	}
}