package org.foomo.flash.logging
{
	import flash.external.ExternalInterface;

	public class ConsoleTarget implements ILoggingTarget
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
			var method:String;

			switch (level) {
				case LogLevel.DEBUG:
					method = 'debug';
					break;
				case LogLevel.INFO:
					method = 'info';
					break;
				case LogLevel.WARN:
					method = 'warn';
					break;
				case LogLevel.ERROR:
					method = 'error';
					break;
				case LogLevel.FATAL:
					method = 'error';
					break;
			}
			ExternalInterface.call('console.' + method, message);
		}
	}
}