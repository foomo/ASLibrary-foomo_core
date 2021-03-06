/*
 * This file is part of the foomo Opensource Framework.
 *
 * The foomo Opensource Framework is free software: you can redistribute it
 * and/or modify it under the terms of the GNU Lesser General Public License as
 * published  by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * The foomo Opensource Framework is distributed in the hope that it will
 * be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with
 * the foomo Opensource Framework. If not, see <http://www.gnu.org/licenses/>.
 */
package org.foomo.managers
{
	import org.foomo.core.Managers;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class SessionManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static initialization
		//-----------------------------------------------------------------------------------------

		Managers.registerClass('org.foomo.flash.managers::ISharedObjectManager', SessionManagerImpl);

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
			if (!_impl) _impl = ISessionManager(Managers.getInstance("org.foomo.flash.managers::ISharedObjectManager"));
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