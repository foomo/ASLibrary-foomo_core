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
package org.foomo.utils
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
		public static function lcFirst(string:Object):String
		{
			return string.toString().substr(0, 1).toLowerCase() + string.toString().substr(1);
		}

		/**
		 * myString -> MyString
		 */
		public static function ucFirst(string:String):String
		{
			return string.substr(0, 1).toUpperCase() + string.substr(1);
		}

		/**
		 * Prepend sth before a given string x times
		 */
		public static function prepend(string:Object, value:Object, repeat:uint=1):String
		{
			for (var i:int=0; i<repeat; i++) string = value.toString() + string.toString();
			return string.toString();
		}

		/**
		 * @param string String to be padded
		 * @param length Length of the string
		 * @param value String to be padded on
		 * @param append If true value will be appended instead of prepended
		 * @return padded string
		 */
		public static function pad(string:Object, length:uint, value:Object, append:Boolean=false):String
		{
			while(string.toString().length < length) string = (append) ? StringUtil.append(string, value) : StringUtil.prepend(string, value);
			return string.toString();
		}

		/**
		 * Append sth before a given string x times
		 */
		public static function append(string:Object, value:Object, repeat:uint=1):String
		{
			for (var i:int=0; i<repeat; i++) string += value.toString();
			return string.toString();
		}

		/**
		 * myString => ['my', 'String']
		 */
		public static function camelCaseSplit(string:Object):Array
		{
			var j:int = 0;
			var ret:Array = [];
			for (var i:int=0; i<string.toString().length; i++) {
				var char:String = string.toString().charAt(i);
				var charUpper:String = char.toUpperCase();
				if (char == charUpper) j++;
				if (!ret[j]) ret[j] = '';
				ret[j] += char;
			}
			return ret;
		}

		/**
		 * myString => MY_STRING
		 */
		public static function camelCaseToUpperCase(string:Object, seperator:Object='_'):String
		{
			return StringUtil.camelCaseSplit(string.toString()).join(seperator.toString()).toUpperCase();
		}

		/**
		 * myString => my_string
		 */
		public static function camelCaseToLowerCase(string:Object, seperator:Object='_'):String
		{
			return StringUtil.camelCaseSplit(string.toString()).join(seperator.toString()).toLowerCase();
		}

		/**
		 * @todo: remove the array check
		 * usage: StringUtilss.substitue('my {0} string', ['foobar']);
		 */
		public static function substitue(string:Object, ... rest):String
		{
			if (rest.length == 1 && rest[0] is Array) rest = rest[0];
			for (var i:int = 0; i < rest.length; ++i) string = string.toString().replace( "{"+i+"}", rest[i]);
			return string.toString();
		}

		/**
		 * @param string subject
		 * @param p partial to search for
		 * @param repl to replace with
		 * @return replaces string
		 */
		public static function replaceAll(string:Object, p:*, repl:*):String
		{
			return string.toString().split(p).join(repl);
		}
	}
}