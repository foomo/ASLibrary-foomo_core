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
package org.foomo.flash.mock
{
	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class ComplexType
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		public var publicString:String = 'foobar';

		public var publicStringArray:Array = ['foo', 'bar']

		public var publicIntArray:Array = [1, 2, 3]

		public var publicObject:Object = {foo:'bar'}

		public var nestedComplexType:NestedComplexType = new NestedComplexType;

		private var _privateString:String = 'foobar';

		private var _readOnlyString:String = 'foobar';

		private var _setOnlyString:String = 'foobar';

		protected var _protectedString:String = 'foobar';

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function get readOnlyString():String
		{
			return this._readOnlyString;
		}

		public function set setOnlyString(value:String):void
		{
			this._setOnlyString = value;
		}
	}
}