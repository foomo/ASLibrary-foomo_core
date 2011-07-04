package org.foomo.managers
{
	import org.foomo.core.Singleton;
	import org.foomo.memory.IUnloader;

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

		public static function addUnloader(type:*, unloader:IUnloader):void
		{
			impl.addUnloader(type, unloader);
		}

		public static function removeUnloader(type:*):void
		{
			impl.removeUnloader(type);
		}
	}
}