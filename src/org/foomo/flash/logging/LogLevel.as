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
package org.foomo.flash.logging
{
	/**
	 * These are the same as from flex to garantee compatibility
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class LogLevel
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const FATAL:int 	= 1000;
		public static const ERROR:int 	= 8;
		public static const WARN:int 	= 6;
		public static const INFO:int 	= 4;
		public static const DEBUG:int 	= 2;
		public static const ALL:int 	= 0;

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		public static function getLevelString(level:int):String
		{
			switch (level) {
				case FATAL:
					return 'FATAL';
					break;
				case ERROR:
					return 'ERROR';
					break;
				case WARN:
					return 'WARN';
					break;
				case INFO:
					return 'INFO';
					break;
				case DEBUG:
					return 'DEBUG';
					break;
				case ALL:
					return 'ALL';
					break;
				default:
					return 'Unkown';
					break;
			}
		}
	}
}