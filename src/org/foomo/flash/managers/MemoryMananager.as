package org.foomo.flash.managers
{
	import org.foomo.flash.core.Singleton;

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
			if (!_impl) _impl = ILogManager(Singleton.getInstance("org.foomo.flash.managers::IMemoryManager"));
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
	}
}