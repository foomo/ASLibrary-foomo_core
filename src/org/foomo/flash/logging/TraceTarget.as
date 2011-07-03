package org.foomo.flash.logging
{
	public class TraceTarget implements ILoggingTarget
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function format(category:String, message:String, level:int):String
		{
			return '[' + LogLevel.getLevelString(level) + '] ' + message + '  in ' + category;
		}

		public function output(message:String, level:int):void
		{
			trace(message);
		}
	}
}