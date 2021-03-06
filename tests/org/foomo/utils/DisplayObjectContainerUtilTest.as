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
	import flash.display.Sprite;

	import flexunit.framework.Assert;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class DisplayObjectContainerUtilTest
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constructor
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
		public function testAddChild():void
		{
			var parent:Sprite = new Sprite;
			var child:Sprite = new Sprite;
			Assert.assertEquals(parent.numChildren, 0);
			DisplayObjectContainerUtil.addChild(child, parent);
			Assert.assertEquals(parent.numChildren, 1);
		}

		[Test]
		public function testRemoveChild():void
		{
			var parent:Sprite = new Sprite;
			var child:Sprite = new Sprite;
			parent.addChild(child);
			Assert.assertEquals(parent.numChildren, 1);
			DisplayObjectContainerUtil.removeChild(child, parent);
			Assert.assertEquals(parent.numChildren, 0);
		}
	}
}