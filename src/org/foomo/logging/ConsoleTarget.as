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
package org.foomo.logging
{
	import flash.external.ExternalInterface;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
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