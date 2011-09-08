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
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	public class DisplayObjectUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Hirachicaly search for the first occurence of the given parent
		 *
		 * @param child				the child
		 * @param classes			array of classes to be searched
		 * @return 					the searched parent, null if not found
		 */
		public static function getParentByClass(child:DisplayObject, clazz:Class):DisplayObject
		{
			var parent:DisplayObject;
			while (child != null) {
				if (child is clazz) {
					parent = child;
					break;
				}
				child = child.parent;
			}
			return parent;
		}

		/**
		 * @param source
		 * @param transparent
		 * @param fillColor
		 * @return
		 */
		public static function getBitmapData(source:DisplayObject, transparent:Boolean=true, fillColor:int=0xffffff):BitmapData
		{
			var bmd:BitmapData;
			if (source.width == 0 || source.height == 0) {
				bmd = DisplayObjectUtil.getDummyBitmapData();
			} else {
				bmd = new BitmapData(source.width, source.height, transparent, fillColor);
				try {
					bmd.draw(source);
				} catch (e:Error) {
					bmd = DisplayObjectUtil.getDummyBitmapData();
				}
			}
			return bmd;
		}

		/**
		 * @param source
		 * @return
		 */
		public static function getBitmap(source:DisplayObject, transparent:Boolean=true, fillColor:int=0xffffff, pixelSnapping:String='auto', smoothing:Boolean=true):Bitmap
		{
			return new Bitmap(DisplayObjectUtil.getBitmapData(source), pixelSnapping, smoothing);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @return 1x1 transparent bitmapdata
		 */
		private static function getDummyBitmapData():BitmapData
		{
			var bmd:BitmapData = new BitmapData(1, 1);
			var sprite:Shape = new Shape;
			sprite.graphics.beginFill(0x000000, 0);
			sprite.graphics.drawRect(0, 0, 1, 1);
			sprite.graphics.endFill();
			bmd.draw(sprite);
			return bmd;
		}
	}
}