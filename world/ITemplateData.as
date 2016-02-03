package world
{
	import flash.utils.ByteArray;

	/**
	 * 模板数据
	 * @author blank
	 * 
	 */
	public interface ITemplateData
	{
		/**
		 * 解析数据
		 * @param data
		 * 
		 */
		function reslove(data:ByteArray):void;
	}
}