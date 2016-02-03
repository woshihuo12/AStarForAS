package world
{
	import flash.events.Event;
	
	import world.aStar.IUnit;
	
	public class World2DEvent extends Event
	{
		/**
		 * 进入世界
		 */
		public static const INTO_WORLD:String="into_world";
		
		/**
		 * 离开世界
		 */
		public static const OUT_WORLD:String="out_world";
		
		/**
		 * 进入节点
		 */
		public static const INTO_NODE:String="into_node";
		
		/**
		 * 离开节点
		 */
		public static const OUT_NODE:String="out_node";
		
		/**
		 * 触发事件的单位
		 */
		private var _unit:IUnit;
		
		public function World2DEvent(
			type:String, 
			unit:IUnit,
			bubbles:Boolean=false, 
			cancelable:Boolean=false
		){
			super(type, bubbles, cancelable);
			
			_unit=unit;
		}
		
		/**
		 * 触发事件的单位
		 */
		public function get unit():IUnit{
			return _unit;
		}
	}
}