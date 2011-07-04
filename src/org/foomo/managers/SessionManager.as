package org.foomo.managers
{
	import org.foomo.core.Singleton;

	public class SessionManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static initialization
		//-----------------------------------------------------------------------------------------

		Singleton.registerClass('org.foomo.flash.managers::ISharedObjectManager', SessionManagerImpl);

		//-----------------------------------------------------------------------------------------
		// ~ Static variables
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static var _impl:ISessionManager;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton instance
		//-----------------------------------------------------------------------------------------

		private static function get impl():ISessionManager
		{
			if (!_impl) _impl = ISessionManager(Singleton.getInstance("org.foomo.flash.managers::ISharedObjectManager"));
			return _impl;
		}

		public static function getInstance():ISessionManager
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

		public static function setLocalData(key:Object, value:*):*
		{
			return impl.setLocalData(key, value);
		}

		public static function getLocalData(key:Object, defaultValue:*=null):*
		{
			return impl.getLocalData(key, defaultValue);
		}

		public static function removeLocalData(key:Object):*
		{
			return impl.removeLocalData(key);
		}

		public static function flushLocal():String
		{
			return impl.flushLocal()
		}

		public static function clearLocal():void
		{
			return impl.clearLocal();
		}
	}
}