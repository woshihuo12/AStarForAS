package functionUtl
{
	
	
	/**
	 * 同时调用多个函数
	 * @author blank
	 * 
	 */
	public class ExecFunctions
	{
		/**
		 * 需要执行的函数列表
		 */
		private var $execFuncs:Vector.<Function>;
		
		/**
		 * 函数的参数列表
		 */
		private var $execArgs:Vector.<Array>;
		
		/**
		 * 函数列表中函数的数目
		 */
		private var _numFunc:uint;
		
		/**
		 * 是否有删除标签(值为 true 时才检查是否有函数需要从函数列表中移除)
		 */		
		private var isHasDelFunc:Boolean;
		
		/**
		 * 已被摧毁
		 */
		private var _destroyed:Boolean;
		
		/**
		 * 添加要执行的函数。
		 * @param execFunc 被添加的函数。
		 * @param args 参数。
		 * <p>不同参数的同一个函数被不能被多次添加，如下：</p>
		 * <listing version="3.0">
		 * private timer:PublicTimer=PublicTimer.getInstance();
		 * 
		 * function func(...args):void{
		 * 	trace(args);
		 * }
		 * 
		 * function addFunc():void{
		 * 	var args:Array=[];
		 * 	
		 * 	for(var i:int=0;i<=10;i++){
		 * 		args.push(i);
		 * 		timer.addExecFunc(func,args);//func只会被添加一次。
		 * 	}
		 * }
		 * </listing>
		 */
		public function addFunc(func:Function,args:Array=null):Boolean{
			if(func != null){
				var index:int=$execFuncs.indexOf(func);
				if(index == -1){
					var len:int=$execFuncs.length;
					
					$execFuncs[len]=func;
					$execArgs[len]=args;
					
					_numFunc++;
					
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 移除要执行的函数。
		 * @param execFunc 要被移除的函数。
		 */
		public function removeFunc(func:Function):void{
			var index:int=$execFuncs.indexOf(func);
			if(index != -1){
				$execFuncs[index]=null;
				$execArgs[index]=null;
				_numFunc--;
				
				isHasDelFunc=true;
			}
		}
		
		/**
		 * 删除带有"删除标签(被置为 null 的函数)"的函数
		 * 
		 */
		private function delFuncByDelLabel():void{
			if(isHasDelFunc){
				for(var i:int=$execFuncs.length-1;i>-1;i--){
					if(!$execFuncs[i]){
						$execFuncs.splice(i,1);
						$execArgs.splice(i,1);
					}
				}
				isHasDelFunc=false;
			}
		}
		
		/**
		 * 执行列表中的函数
		 * @return 
		 * 
		 */
		public function exec():Boolean{
			var bool:Boolean;
			
			/*执行回调函数*/
			var callFunc:Function;
			for(var i:int=0;i<$execFuncs.length;i++){/*在列表中的函数执行时添加函数,则必须用此方法循环,方可确保新添加的函数在本次循环中被执行*/
				callFunc=$execFuncs[i];
				if(callFunc != null){
					if(callFunc.apply(null, $execArgs[i])){
						bool=true;
					}
				}
			}
			
			delFuncByDelLabel();
			
			return bool;
		}
		
		/**
		 * 执行函数列表中的函数,并附加指定的参数
		 * @param args
		 * 
		 */
		public function exec_additionalArgs(args:Array):Boolean{
			var bool:Boolean;
			
			/*执行回调函数*/
			var callFunc:Function;
			for(var i:int=0;i<$execFuncs.length;i++){/*在列表中的函数执行时添加函数,则必须用此方法循环,方可确保新添加的函数在本次循环中被执行*/
				callFunc=$execFuncs[i];
				if(callFunc != null){
					if(callFunc.apply(null, args?($execArgs[i]?args.concat($execArgs[i]):args):null)){
						bool=true;;
					}
				}
			}
			
			delFuncByDelLabel();
			
			return bool;
		}
		
		/**
		 * 执行函数列表中的函数,并指定的参数
		 * @param args
		 * @return 
		 * 
		 */
		public function exec_appointedArgs(args:Array):Boolean{
			var bool:Boolean;
			
			/*执行回调函数*/
			var callFunc:Function;
			for(var i:int=0;i<$execFuncs.length;i++){/*在列表中的函数执行时添加函数,则必须用此方法循环,方可确保新添加的函数在本次循环中被执行*/
				callFunc=$execFuncs[i];
				if(callFunc != null){
					if(callFunc.apply(null,args)){
						bool=true;;
					}
				}
			}
			
			delFuncByDelLabel();
			
			return bool;
		}
		
		public function reset():void{
			$execFuncs=new Vector.<Function>();
			$execArgs=new Vector.<Array>();
			
			_numFunc=0;
		}
		
		public function destroy():void{
			$execFuncs=null;
			$execArgs=null;
			
			_destroyed=true;
		}
		
		/**
		 * 同时调用多个函数
		 * 
		 */
		public function ExecFunctions(){
			$execFuncs=new Vector.<Function>();
			$execArgs=new Vector.<Array>();
		}
		
		/**
		 * 函数列表中函数的数目
		 */
		public function get numFunc():uint{
			return _numFunc;
		}
		
		public function get destroyed():Boolean{
			return _destroyed;
		}
	}
}