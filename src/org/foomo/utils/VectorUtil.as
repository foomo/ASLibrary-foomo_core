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
	public class VectorUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Returns the index of the item in the Array.
		 */
		public static function getItemIndex(item:Object, source:*):int
		{
			var n:int = source.length;
			for (var i:int = 0; i < n; i++) if (source[i] === item) return i;
			return -1;
		}

		/**
		 * Removes all items from an array
		 */
		public static function removeAll(vector:*):*
		{
			return vector.splice(0, vector.length);
		}

		/**
		 *
		 */
		public static function toArray(vector:*):Array
		{
			var ret:Array = [];
			for each (var elem:* in vector) ret.push(elem);
			return ret;
		}
	}
}