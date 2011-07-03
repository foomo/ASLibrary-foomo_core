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
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;

	import org.foomo.flash.managers.MemoryMananager;

	/**
	 * This offers a shortcut to add all common unloader
	 * Note: using this method could mean that you will compile some classes
	 * into you project you might otherwise wouldn't need. So be aware of this!
	 *
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class Unloader
	{
		/**
		 * Shortcut to include all basic unloader
		 */
		public static function addAll():void
		{
			MemoryMananager.addUnloader(BitmapData, new BitmapDataUnloader);
			MemoryMananager.addUnloader(Bitmap, new BitmapUnloader);
			MemoryMananager.addUnloader(DisplayObjectContainer, new DisplayObjectContainerUnloader);
			MemoryMananager.addUnloader(DisplayObject, new DisplayObjectUnloader);
			MemoryMananager.addUnloader(Loader, new LoaderUnloader);
			MemoryMananager.addUnloader(MovieClip, new MovieClipUnloader);
		}
	}
}