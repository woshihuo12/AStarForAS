package world
{
	import flash.events.EventDispatcher;
	
	import world.aStar.AStar;
	import world.aStar.IUnit;
	import world.aStar.Node;
	
	/**
	 * 2D世界
	 * @author blank
	 * 
	 */
	public class World2D extends EventDispatcher
	{
		/**
		 * A星
		 */
		protected var $aStar:AStar;
		
		/**
		 * 2D世界
		 * @param terrainNodes
		 * @param numCols
		 * @param numRows
		 * @param isFourWay
		 * 
		 */
		public function World2D(
			terrainNodes:Vector.<Vector.<ITerrainNode>>,
			numCols:uint,
			numRows:uint,
			isFourWay:Boolean=false
		){
			$aStar=new AStar(numCols,numRows,isFourWay);
			
			for(var i:uint=0;i<numCols;i++){
				for(var j:uint=0;j<numRows;j++){
					$aStar.getNode(i,j).addUnit(terrainNodes[i][j]);
				}
			}
		}
		
		/**
		 * 单位进入节点
		 * @param unit
		 * @param desNode
		 * 
		 */
		protected function moveUnitIntoNode(unit:IUnit,desNode:Node):void{
			desNode.addUnit(unit)
			dispatchEvent(new World2DEvent(World2DEvent.INTO_NODE,unit));
		}
		
		/**
		 * 单位移除节点
		 * @param unit
		 * @return 
		 * 
		 */
		protected function moveUnitOutNode(unit:IUnit):Boolean{
			if($aStar.getNode(unit.world_x,unit.world_y).rmUnit(unit)){
				dispatchEvent(new World2DEvent(World2DEvent.OUT_NODE,unit));
				return true;
			}
			return false;
		}
		
		/**
		 * 添加单位
		 * @param unit
		 * @param world_x
		 * @param world_y
		 * 
		 */
		public function addUnit(unit:IUnit,world_x:uint,world_y:uint):void{
			dispatchEvent(new World2DEvent(World2DEvent.INTO_WORLD,unit));
			moveUnitIntoNode(unit,$aStar.getNode(world_x,world_y));
		}
		
		/**
		 * 移除单位
		 * @param unit
		 * 
		 */
		public function rmUnit(unit:IUnit):void{
			if(moveUnitOutNode(unit)){
				dispatchEvent(new World2DEvent(World2DEvent.OUT_WORLD,unit));
			}
		}
		
		/**
		 * 移动单位
		 * @param unit
		 * @param toWorld_x
		 * @param toWorld_y
		 * 
		 */
		public function moveUnit(
			unit:IUnit,
			toWorld_x:uint,
			toWorld_y:uint
		):void{
			if(moveUnitOutNode(unit)){
				moveUnitIntoNode(unit,$aStar.getNode(toWorld_x,toWorld_y));
			}
		}
		
		/**
		 * 查找路径
		 * @param startWorld_x
		 * @param startWorld_y
		 * @param endWorld_x
		 * @param endWorld_y
		 * @return 
		 * 
		 */
		public function findPath(
			startWorld_x:uint,
			startWorld_y:uint,
			endWorld_x:uint,
			endWorld_y:uint
		):Vector.<Node>{
			return $aStar.findPath(
				$aStar.getNode(startWorld_x,startWorld_y),
				$aStar.getNode(endWorld_x,endWorld_y)
			);
		}
		
		/**
		 * 查找从指定节点开始的可移动范围
		 * @param startWorld_x
		 * @param startWorld_y
		 * @param costLimit
		 * @return 
		 * 
		 */
		public function getWalkableRange(
			startWorld_x:uint,
			startWorld_y:uint,
			costLimit:int
		):Vector.<Node>{
			return $aStar.walkableRange(
				$aStar.getNode(startWorld_x,startWorld_y),
				costLimit
			);
		}
		
		/**
		 * 获取节点
		 * @param world_x
		 * @param world_y
		 * @return 
		 * 
		 */
		public function getNode(world_x:uint,world_y:uint):Node{
			return $aStar.getNode(world_x,world_y);
		}
	}
}