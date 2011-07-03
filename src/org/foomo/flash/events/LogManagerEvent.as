package org.foomo.flash.events
{
	import flash.events.Event;

	import mx.logging.LogEvent;

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

		private var _level:int;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function LogManagerEvent(type:String, message:String, level:int=0)
		{
			this.message = message;
			this.level = level;

			super(type);
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

		public function get message():String
		{
			return this._message;
		}
		public function set message(value:String):void
		{
			this._message = value;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		public override function clone():Event
		{
			return new LogManagerEvent(type, this.message, this.level);
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