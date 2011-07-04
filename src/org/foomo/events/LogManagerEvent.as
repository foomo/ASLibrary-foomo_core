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
*/package org.foomo.events
{
	import flash.events.Event;

	import mx.logging.LogEvent;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class LogManagerEvent extends Event
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const LOG:String = "log";

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _message:String;

		private var _category:String;

		private var _level:int;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function LogManagerEvent(type:String, category:String, message:String, level:int=0)
		{
			this._message = message;
			this._category = category;
			this._level = level;

			super(type);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function get category():String
		{
			return this._category;
		}

		public function get level():int
		{
			return this._level;
		}

		public function get message():String
		{
			return this._message;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		public override function clone():Event
		{
			return new LogManagerEvent(this.type, this.category, this.message, this.level);
		}

		/**
		 * @inherit
		 */
		public override function toString():String
		{
			return formatToString("LogManagerEvent", "message", "level");
		}
	}
}