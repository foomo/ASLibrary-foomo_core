package org.foomo.managers
{
	import org.foomo.memory.IUnloader;

	public interface IMemoryManager
	{
		function gc():void;
		function unload(obj:Object):void;
		function addUnloader(type:*, unloader:IUnloader):void;
		function removeUnloader(type:*):void;
	}
}