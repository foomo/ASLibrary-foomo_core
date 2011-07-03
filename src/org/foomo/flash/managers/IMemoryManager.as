package org.foomo.flash.managers
{
	import org.foomo.flash.memory.IUnloader;

	public interface IMemoryManager
	{
		function gc():void;
		function unload(obj:Object):void;
		function addUnloader(type:Class, unloader:IUnloader):void;
		function removeUnloader(type:Class):void;
	}
}