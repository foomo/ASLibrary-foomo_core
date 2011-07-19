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
	import org.foomo.logging.ILoggingTarget;
	import org.foomo.logging.LogLevel;
	import org.foomo.logging.TraceTarget;

	[Event(name="log", type="org.foomo.events.LogManagerEvent")]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class LogManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static initialization
		//-----------------------------------------------------------------------------------------

		Managers.registerClass('org.foomo.flash.managers::ILogManager', LogManagerImpl);

		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static var DEFAULT_LOG_LEVEL:int = LogLevel.WARN;
		public static var DEFAULT_LOGGING_TARGET:Class = TraceTarget;

		//-----------------------------------------------------------------------------------------
		// ~ Static variables
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static var _impl:ILogManager;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton instance
		//-----------------------------------------------------------------------------------------

		private static function get impl():ILogManager
		{
			if (!_impl) _impl = ILogManager(Managers.getInstance("org.foomo.flash.managers::ILogManager"));
			return _impl;
		}

		public static function getInstance():ILogManager
		{
			return impl;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		public static function get level():int
		{
			return impl.level;
		}

		public static function set level(value:int):void
		{
			impl.level = value;
		}

		public static function isDebug():Boolean
		{
			return impl.isDebug();
		}

		public static function isInfo():Boolean
		{
			return impl.isInfo();
		}

		public static function isWarn():Boolean
		{
			return impl.isWarn()
		}

		public static function isError():Boolean
		{
			return impl.isError();
		}

		public static function isFatal():Boolean
		{
			return impl.isFatal();
		}

		public static function log(category:*, level:int, message:String, ... rest):void
		{
			impl.log(category, level, message, (rest) ? rest : []);
		}

		public static function debug(category:*, message:String, ... rest):void
		{
			impl.log(category, LogLevel.DEBUG, message, (rest) ? rest : []);
		}

		public static function info(category:*, message:String, ... rest):void
		{
			impl.log(category, LogLevel.INFO, message, (rest) ? rest : []);
		}

		public static function warn(category:*, message:String, ... rest):void
		{
			impl.log(category, LogLevel.WARN, message, (rest) ? rest : []);
		}

		public static function error(category:*, message:String, ... rest):void
		{
			impl.log(category, LogLevel.ERROR, message, (rest) ? rest : []);
		}

		public static function fatal(category:*, message:String, ... rest):void
		{
			impl.log(category, LogLevel.FATAL, message, (rest) ? rest : []);
		}

		public static function addLoggingTarget(target:ILoggingTarget):String
		{
			return impl.addLoggingTarget(target);
		}

		public static function removeLoggingTarget(target:*):Boolean
		{
			return impl.removeLoggingTarget(target);
		}

		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			return _impl.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			return _impl.removeEventListener(type, listener, useCapture);
		}
	}
}