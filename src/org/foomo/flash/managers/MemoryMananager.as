package org.foomo.flash.managers
{
	import org.foomo.flash.core.Singleton;
	import org.foomo.flash.memory.IUnloader;

	public class MemoryMananager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static initialization
		//-----------------------------------------------------------------------------------------

		Singleton.registerClass('org.foomo.flash.managers::IMemoryManager', MemoryManagerImpl);

		//-----------------------------------------------------------------------------------------
		// ~ Static variables
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static var _impl:IMemoryManager;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton instance
		//-----------------------------------------------------------------------------------------

		private static function get impl():IMemoryManager
		{
			if (!_impl) _impl = IMemoryManager(Singleton.getInstance("org.foomo.flash.managers::IMemoryManager"));
			return _impl;
		}

		/**
		 * @return ILogManager
		 */
		public static function getInstance():IMemoryManager
		{
			return impl;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		public static function gc():void
		{
			impl.gc();
		}

		public static function unload(obj:Object):void
		{
			impl.unload(obj);
		}

		public static function addUnloader(type:Class, unloader:IUnloader):void
		{
			impl.addUnloader(type, unloader);
		}

		public static function removeUnloader(type:Class):void
		{
			impl.removeUnloader(type);
		}
	}
}