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
package org.foomo.memory
{
	import org.foomo.managers.MemoryMananager;

	/**
	 * This offers a shortcut to add all common unloader
	 * NOTE: I am not using the actual classes as I don't want to link them into the swf if they are not needed
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class Unloader
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Shortcut to include all basic unloader
		 */
		public static function addAll():void
		{
			MemoryMananager.addUnloader('flash.display::BitmapData', new BitmapDataUnloader);
			MemoryMananager.addUnloader('flash.display::Bitmap', new BitmapUnloader);
			MemoryMananager.addUnloader('flash.display::DisplayObjectContainer', new DisplayObjectContainerUnloader);
			MemoryMananager.addUnloader('flash.display::DisplayObject', new DisplayObjectUnloader);
			MemoryMananager.addUnloader('org.foomo.memory::IUnload', new IUnloadUnloader);
			MemoryMananager.addUnloader('flash.display::Loader', new LoaderUnloader);
			MemoryMananager.addUnloader('flash.display::MovieClip', new MovieClipUnloader);
		}

		/**
		 * Shortcut to remove all basic unloader
		 */
		public static function removeAll():void
		{
			MemoryMananager.removeUnloader('flash.display::BitmapData');
			MemoryMananager.removeUnloader('flash.display::Bitmap');
			MemoryMananager.removeUnloader('flash.display::DisplayObjectContainer');
			MemoryMananager.removeUnloader('flash.display::DisplayObject');
			MemoryMananager.removeUnloader('org.foomo.memory::IUnload');
			MemoryMananager.removeUnloader('flash.display::Loader');
			MemoryMananager.removeUnloader('flash.display::MovieClip');
		}
	}
}