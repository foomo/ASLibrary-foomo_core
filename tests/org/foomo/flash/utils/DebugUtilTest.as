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
	import flash.display.MovieClip;

	import flexunit.framework.Assert;

	import org.foomo.flash.utils.mock.ComplexType;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class DebugUtilTest
	{
		//-----------------------------------------------------------------------------------------
		// ~ Initialization
		//-----------------------------------------------------------------------------------------

		[Before]
		public function setUp():void
		{
		}

		[After]
		public function tearDown():void
		{
		}

		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}

		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}

		//-----------------------------------------------------------------------------------------
		// ~ Test methods
		//-----------------------------------------------------------------------------------------

		[Test]
		public function testExport():void
		{
			Assert.assertEquals('Boolean true', DebugUtil.export(true));
			Assert.assertEquals('int 13', DebugUtil.export(13));
			Assert.assertEquals('Number 13.3', DebugUtil.export(13.3));
			Assert.assertEquals("String 'My string' (length=9)", DebugUtil.export('My string'));

			//trace(DebugUtil.export(new MovieClip));
			//trace(DebugUtil.export(['foo', 'bar']));
			//trace(DebugUtil.export({foo:'bar', 0:13}));
			//trace(DebugUtil.export(new ComplexType));
		}
	}
}