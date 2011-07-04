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
package org.foomo.ui
{
	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class Terminal
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static const RESET:String 	= '[0m';

		public static const BLACK:String 	= '[0;30m';
		public static const RED:String 		= '[0;31m';
		public static const GREEN:String 	= '[0;32m';
		public static const YELLOW:String 	= '[0;33m';
		public static const BLUE:String 	= '[0;34m';
		public static const PURPLE:String 	= '[0;35m';
		public static const CYAN:String 	= '[0;36m';
		public static const GREY:String 	= '[0;37m';

		public static const BLACK_BOLD:String  			= '[1;30m';
		public static const RED_BOLD:String  			= '[1;31m';
		public static const GREEN_BOLD:String  			= '[1;32m';
		public static const YELLOW_BOLD:String  		= '[1;33m';
		public static const BLUE_BOLD:String  			= '[1;34m';
		public static const PURPLE_BOLD:String  		= '[1;35m';
		public static const CYAN_BOLD:String  			= '[1;36m';
		public static const GREY_BOLD:String  			= '[1;37m';

		public static const BLACK_UNDERLINED:String  	= '[4;30m';
		public static const RED_UNDERLINED:String  		= '[4;31m';
		public static const GREEN_UNDERLINED:String  	= '[4;32m';
		public static const YELLOW_UNDERLINED:String  	= '[4;33m';
		public static const BLUE_UNDERLINED:String  	= '[4;34m';
		public static const PURPLE_UNDERLINED:String  	= '[4;35m';
		public static const CYAN_UNDERLINED:String  	= '[4;36m';
		public static const WHITE_UNDERLINED:String  	= '[4;37m';

		public static const BACKGROUND_BLACK:String  	= '[40m';
		public static const BACKGROUND_RED:String  		= '[41m';
		public static const BACKGROUND_GREEN:String  	= '[42m';
		public static const BACKGROUND_YELLOW:String  	= '[43m';
		public static const BACKGROUND_BLUE:String  	= '[44m';
		public static const BACKGROUND_PURPLE:String  	= '[45m';
		public static const BACKGROUND_CYAN:String  	= '[46m';
		public static const BACKGROUND_WHITE:String  	= '[47m';

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Colorize your string for terminal use
		 */
		public static function format(value:String,style:String):String
		{
			return style + value + Terminal.RESET;
		}
	}
}