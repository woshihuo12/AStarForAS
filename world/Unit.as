package world
{
	import flash.display.Sprite;
	
	import functionUtl.ExecFunctions;
	
	import world.aStar.IUnit;
	
	/**
	 * 世界单位
	 * @author blank
	 * 
	 */
	public class Unit extends Sprite implements IUnit
	{
		/**
		 * 世界坐标_x
		 */
		protected var _world_x:int=-1;
		
		/**
		 * 世界坐标_y
		 */
		protected var _world_y:int=-1;
		
		/**
		 * 是否可被穿越
		 */
		protected var _isPassable:Boolean;
		
		/**
		 * 穿越代价
		 */
		protected var _passCost:int;
		
		/**
		 * 世界坐标改变的回调函数执行对象
		 */
		protected var execFunc_worldCoordinate_change:ExecFunctions;
		
		/**
		 * 可穿越状态改变的回调函数执行对象
		 */
		protected var execFunc_isPassable_change:ExecFunctions;
		
		/**
		 * 穿越代价改变的回调函数执行对象
		 */
		protected var execFunc_passCost_change:ExecFunctions;
		
		public function addCallbackFunc_worldCoordinate_change(callback:Function,args:Array=null):void{
			execFunc_worldCoordinate_change.addFunc(callback,args);
		}
		
		public function rmCallbackFunc_worldCoordinate_change(callback:Function):void{
			execFunc_worldCoordinate_change.removeFunc(callback);
		}
		
		public function addCallbackFunc_isPassable_change(callback:Function):void{
			execFunc_isPassable_change.addFunc(callback);
		}
		
		public function rmCallbackFunc_isPassable_change(callback:Function):void{
			execFunc_isPassable_change.removeFunc(callback);
		}
		
		public function addCallbackFunc_passCost_change(callback:Function):void{
			execFunc_passCost_change.addFunc(callback);
		}
		
		public function rmCallbackFunc_passCost_change(callback:Function):void{
			execFunc_passCost_change.removeFunc(callback);
		}
		
		public function Unit(){
			execFunc_worldCoordinate_change=new ExecFunctions();
			execFunc_isPassable_change=new ExecFunctions();
			execFunc_passCost_change=new ExecFunctions();
		}
		
		public function setWorldCoordinate(world_x:int,world_y:int):void{
			if(world_x != _world_x || world_y != _world_y){
				_world_x=world_x;
				_world_y=world_y;
				
				execFunc_worldCoordinate_change.exec();
			}
		}
		
		public function get world_x():int{
			return _world_x;
		}
		
		public function get world_y():int{
			return _world_y;
		}
		
		public function set isPassable(value:Boolean):void{
			if(value != _isPassable){
				_isPassable=value;
				
				execFunc_isPassable_change.exec();
			}
		}
		
		public function get isPassable():Boolean
		{
			return _isPassable;
		}
		
		public function set passCost(value:int):void{
			if(value != _passCost){
				_passCost=value;
				
				execFunc_passCost_change.exec();
			}
		}
		
		public function get passCost():int{
			return _passCost;
		}
	}
}