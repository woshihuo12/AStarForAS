package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;
	
	import world.Unit;
	import world.aStar.AStar;
	import world.aStar.Node;
	
	[SWF(width = 1144, height = 768, backgroundColor = 0xEAF2FC, frameRate = 30)]
	/**
	 * A星测试
	 * @author blank
	 * 
	 */
	public class aStarTest extends Sprite
	{
		private var astar:AStar;
		
		/**地图节点的大小*/
		private var cellSize:int=4;
		
		/**地图的列数*/
		private var cols:int=128;
		
		/**地图的行数*/
		private var rows:int=128;
		
		/**人物的当前位置*/
		private var manLoc:Node;
		
		private var timeShow:TextField;
		
		private var drawPathSpt:Sprite;
		
		private function drawMap():void{
			graphics.lineStyle(1,0xcccccc);
			
			for(var i:int=0;i<astar.numCols;i++){
				graphics.moveTo(i*cellSize,0);
				graphics.lineTo(i*cellSize,astar.numRows*cellSize);
			}
			for(var j:int=0;j<astar.numRows;j++){
				graphics.moveTo(0,j*cellSize);
				graphics.lineTo(astar.numCols*cellSize,j*cellSize);
			}
			
			CONFIG::debugging{
				trace("正在调试模式下运行!");
			}
		}
		
		private function addUnits():void{
			var len:int=cols*rows*.3;
			
			for(var i:uint=0;i<len;i++){
				var u:Unit=new Unit();
				if(Math.random() >= .30){
					u.isPassable=false;
					
					u.graphics.clear();
					u.graphics.beginFill(0xff0000,1);
					u.graphics.drawRect(0,0,cellSize,cellSize);
				}else{
					u.isPassable=true;
					u.passCost=1+Math.random() * 10;
					
					u.graphics.clear();
					u.graphics.beginFill(u.passCost * 25 << 8,1);
					u.graphics.drawRect(0,0,cellSize,cellSize);
				}
				addChild(u);
				
				var n:Node;
				while((n=astar.getNode(Math.random()*cols,Math.random()*rows)).unitNum == 0){
					n.addUnit(u);
					u.x=n.world_x*cellSize;
					u.y=n.world_y*cellSize;
					
					break;
				}
			}
		}
		
		private function drawPath(path:Vector.<Node>):void{
			if(path != null){
				var len:int=path.length;
				if(len>0){
					drawPathSpt.graphics.clear();
					var currNode:Node=path[0];
					drawPathSpt.graphics.moveTo(currNode.world_x*cellSize+cellSize/2,currNode.world_y*cellSize+cellSize/2);
					drawPathSpt.graphics.lineStyle(1,0xff0000);
					for(var i:int=1;i<len;i++){
						currNode=path[i];
						drawPathSpt.graphics.lineTo(currNode.world_x*cellSize+cellSize/2,currNode.world_y*cellSize+cellSize/2);
						drawPathSpt.graphics.moveTo(currNode.world_x*cellSize+cellSize/2,currNode.world_y*cellSize+cellSize/2);
					}
				}
			}
		}
		
		private function startFindPath(evt:MouseEvent):void{
			var tempNode:Node=astar.getNode(mouseX/cellSize,mouseY/cellSize);
			if(tempNode){
				if(tempNode.walkable){
					if(manLoc == null){
						manLoc=tempNode;
					}else{
						var lastTime:Number=getTimer();
						//graphics.clear();
						//astar.graphics=graphics;
						//astar.cellSize=cellSize;
						//astar.graphics.beginFill(0xffff00);
						var path:Vector.<Node>=astar.findPath(manLoc,tempNode);
						if(path){
							timeShow.text="寻路用时:"+String(getTimer()-lastTime)+" ms";
						}else{
							timeShow.text="未找到路径";
						}
						manLoc=tempNode;
						drawPath(path);
					}
				}
			}
			
		}
		
		public function aStarTest(){
			//http://blog.ivank.net/binary-search-tree-in-as3.html
			
			stage.align=StageAlign.TOP;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			
			astar=new AStar(cols,rows);
			//astar.heuristic=AStar.diagonal;
			drawMap();
			addUnits();
			
			drawPathSpt=new Sprite();
			addChild(drawPathSpt);
			
			timeShow=new TextField();
			addChild(timeShow);
			timeShow.text="寻路用时:###### ms";
			timeShow.autoSize=TextFieldAutoSize.LEFT;
			timeShow.x=cols*cellSize;
			
			stage.addEventListener(MouseEvent.CLICK,startFindPath);
			
			
		}
	}
}