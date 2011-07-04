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
package org.foomo.flash.managers
{
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;

	import org.foomo.flash.events.LogManagerEvent;
	import org.foomo.flash.logging.ILoggingTarget;
	import org.foomo.flash.logging.LogLevel;
	import org.foomo.flash.ui.Terminal;
	import org.foomo.flash.utils.ClassUtil;
	import org.foomo.flash.utils.StringUtil;

	//[ExcludeClass]

	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	public class LogManagerImpl extends EventDispatcher implements ILogManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * Current log level
		 */
		private var _level:int;
		/**
		 * Current logging targets
		 */
		private var _loggingTargets:Array = new Array;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 */
		private static var _instance:ILogManager;

		/**
		 * @private
		 */
		public function LogManagerImpl()
		{
			this._level = LogManager.DEFAULT_LOG_LEVEL;
			this.addLoggingTarget(new LogManager.DEFAULT_LOGGING_TARGET);
		}

		/**
		 * @private
		 */
		public static function getInstance():ILogManager
		{
			if (!_instance) _instance = new LogManagerImpl();
			return _instance;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function get level():int
		{
			return this._level;
		}

		public function set level(value:int):void
		{
			this._level = value;
		}

		public function isDebug():Boolean
		{
			return (this.level <= LogLevel.DEBUG);
		}

		public function isInfo():Boolean
		{
			return (this.level <= LogLevel.INFO);
		}

		public function isWarn():Boolean
		{
			return (this.level <= LogLevel.WARN);
		}

		public function isError():Boolean
		{
			return (this.level <= LogLevel.ERROR);
		}

		public function isFatal():Boolean
		{
			return (this.level <= LogLevel.FATAL);
		}

		public function addLoggingTarget(target:ILoggingTarget):String
		{
			var id:String = ClassUtil.getQualifiedName(target);
			if (!this._loggingTargets[id]) {
				this._loggingTargets[id] = target;
				return id;
			}  else {
				return null;
			}
		}

		public function removeLoggingTarget(target:*):Boolean
		{
			var id:String = ClassUtil.getQualifiedName(target);
			if (this._loggingTargets[id]) {
				delete this._loggingTargets[id];
				return true;
			} else {
				return false;
			}
		}

		public function log(category:*, level:int, message:String, parameters:Array):void
		{
			if (level < this.level) return;

			category = this.getCategoryName(category)
			message =  StringUtil.substitue(message, parameters);

			for each (var target:ILoggingTarget in this._loggingTargets) target.output(target.format(category, message, level), level);

			this.dispatchEvent(new LogManagerEvent(LogManagerEvent.LOG, category, message, level))
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		private function getCategoryName(value:*):String
		{
			return (value is String) ? value as String : ClassUtil.getQualifiedName(value);
		}
	}
}