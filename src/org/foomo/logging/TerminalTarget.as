package org.foomo.logging
{
	import org.foomo.ui.Terminal;

	public class TerminalTarget implements ILoggingTarget
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function format(category:String, message:String, level:int):String
		{
			var style:String;

			switch (level) {
				case LogLevel.DEBUG:
					style = Terminal.GREEN;
					break;
				case LogLevel.INFO:
					style = Terminal.CYAN;
					break;
				case LogLevel.WARN:
					style = Terminal.PURPLE;
					break;
				case LogLevel.ERROR:
					style = Terminal.RED;
					break;
				case LogLevel.FATAL:
					style = Terminal.RED_BOLD;
					break;
			}
			return Terminal.format('[' + LogLevel.getLevelString(level) + '] ', style) + message + Terminal.format('  in ' + category, Terminal.GREY)
		}

		public function output(message:String, level:int):void
		{
			trace(message);
		}
	}
}