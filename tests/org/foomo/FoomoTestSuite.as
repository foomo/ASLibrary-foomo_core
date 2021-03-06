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
package org.foomo
{
	import org.foomo.utils.ArrayUtilTest;
	import org.foomo.utils.ClassUtilTest;
	import org.foomo.utils.DebugUtilTest;
	import org.foomo.utils.DisplayObjectContainerUtilTest;
	import org.foomo.utils.DisplayObjectUtilTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class FoomoTestSuite
	{
		public var test1:org.foomo.utils.ArrayUtilTest;
		public var test2:org.foomo.utils.ClassUtilTest;
		public var test3:org.foomo.utils.DisplayObjectContainerUtilTest;
		public var test4:org.foomo.utils.DisplayObjectUtilTest;
		public var test5:org.foomo.utils.DebugUtilTest;
	}
}