package org.foomo.flash.managers
{
	import org.foomo.flash.core.Singleton;

	public class SharedOjectManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static initialization
		//-----------------------------------------------------------------------------------------

		Singleton.registerClass('org.foomo.flash.managers::ISharedObjectManager', SharedObjectManagerImpl);

		//-----------------------------------------------------------------------------------------
		// ~ Static variables
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static var _impl:ISharedObjectManager;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton instance
		//-----------------------------------------------------------------------------------------

		private static function get impl():ISharedObjectManager
		{
			if (!_impl) _impl = ISharedObjectManager(Singleton.getInstance("org.foomo.flash.managers::ISharedObjectManager"));
			return _impl;
		}

		public static function getInstance():ISharedObjectManager
		{
			return impl;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		public static function get sessionId():String
		{
			return impl.sessionId
		}

		public static  function get clientId():String
		{
			return impl.clientId;
		}

		public static function get localIsAvailable():Boolean
		{
			return impl.localIsAvailable;
		}

		public static function setLocalData(key:*, value:*):void
		{
			impl.setLocalData(key, value);
		}

		public static function getLocalData(key:*):*
		{
			return impl.getLocalData(key);
		}

		public static function removeLocalData(key:*):*
		{
			return removeLocalData(key);
		}

		public static function flushLocal():String
		{
			return impl.flushLocal()
		}
	}
}