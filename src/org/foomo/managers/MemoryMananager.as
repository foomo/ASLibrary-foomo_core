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
	import org.foomo.memory.IUnloader;

	/**
	 * Note: You need to register unloaders in order to unload stuff i.e. org.foomo.memory.Unloader.addAll()
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class MemoryMananager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static initialization
		//-----------------------------------------------------------------------------------------

		Managers.registerClass('org.foomo.flash.managers::IMemoryManager', MemoryManagerImpl);

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
			if (!_impl) _impl = IMemoryManager(Managers.getInstance("org.foomo.flash.managers::IMemoryManager"));
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