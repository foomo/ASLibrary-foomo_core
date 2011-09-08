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
	public class ArrayUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static function merge(source:Array, ... arrays):void
		{
			for each (var array2:Array in arrays) {
				for (var key:Object in array2)  {
					if (key is int && !source[key]) {
						source.push(array2[key]);
					} else {
						source[key] = array2[key];
					}
				}
			}
		}

		/**
		 *
		 */
		public static function ccontainsValue(source:Array, value:Object):Boolean
		{
			return (source.indexOf(value) >= 0);
		}

		/**
		 *
		 */
		public static function copy(source:Array):Array
		{
			var ret:Array = [];
			for (var key:Object in source) ret[key] = source[key];
			return ret;
		}

		/**
		 * Removes all items from an array
		 */
		public static function removeAll(source:Array):*
		{
			return source.splice(0, source.length);
		}
	}
}