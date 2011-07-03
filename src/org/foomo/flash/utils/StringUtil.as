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
package org.foomo.flash.utils
{
	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	public class StringUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * MyString -> myString
		 */
		public static function lcFirst(value:String):String
		{
			return value.substr(0, 1).toLowerCase() + value.substr(1);
		}

		/**
		 * myString -> MyString
		 */
		public static function ucFirst(value:String):String
		{
			return value.substr(0, 1).toUpperCase() + value.substr(1);
		}

		/**
		 * usage: StringUtilss.substitue('my {0} string', ['foobar']);
		 */
		public static function substitue(message:String, parameters:Array):String
		{
			for (var i:int = 0; i < parameters.length; ++i) message = message.replace( "{"+i+"}", parameters[i]);
			return message;
		}
	}
}