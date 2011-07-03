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
package org.foomo.flash.memory
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	import org.foomo.flash.managers.MemoryMananager;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class DisplayObjectContainerUnloader implements IUnloader
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Removes all children and unloads them too
		 */
		public function unload(object:Object):void
		{
			var con:DisplayObjectContainer = DisplayObjectContainer(object);
			while (con.numChildren > 0) MemoryMananager.unload(con.removeChildAt(0));
		}
	}
}