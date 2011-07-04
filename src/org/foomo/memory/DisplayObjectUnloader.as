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
	import flash.events.Event;

	import mx.managers.SystemManager;

	import org.foomo.logging.LogLevel;
	import org.foomo.managers.LogManager;
	import org.foomo.utils.DebugUtil;

	[ExcludeClass]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class DisplayObjectUnloader implements IUnloader
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static variables
		//-----------------------------------------------------------------------------------------

		public static var debug:Boolean = false;

		private static var _orphans:Array;

		private static var _logLevel:int;

		private static var _verbose:Boolean;

		private static var _recordOrphans:Boolean = false;

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function unload(object:Object):void
		{
			if (DisplayObjectUnloader.debug) object.addEventListener(Event.ENTER_FRAME, DisplayObjectUnloader.orphantEnterFrameHandler, false, 0, true)
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		public static function logOrphans(verbose:Boolean=true, level:int=LogLevel.DEBUG):void
		{
			if (!DisplayObjectUnloader.debug) LogManager.info(DisplayObjectUnloader, 'You need to set DisplayObjectUnloader.debug to true in order to track orphants')
			DisplayObjectUnloader._logLevel = level;
			DisplayObjectUnloader._verbose = verbose;
			DisplayObjectUnloader._orphans = new Array;
			SystemManager.getSWFRoot({}).addEventListener(Event.ENTER_FRAME, DisplayObjectUnloader.swfRoot_enterFrameHandler);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private static methods
		//-----------------------------------------------------------------------------------------

		private static function swfRoot_enterFrameHandler(event:Event):void
		{
			if (DisplayObjectUnloader._recordOrphans) {
				var report:String = '';
				DisplayObjectUnloader._recordOrphans = false;

				SystemManager.getSWFRoot({}).removeEventListener(Event.ENTER_FRAME, DisplayObjectUnloader.swfRoot_enterFrameHandler);
				if (DisplayObjectUnloader._verbose) {
					LogManager.log(DisplayObjectContainerUnloader, DisplayObjectUnloader._logLevel, 'Orphant list:\n{0}', DebugUtil.export(DisplayObjectUnloader._orphans));
				} else {
					LogManager.log(DisplayObjectContainerUnloader, DisplayObjectUnloader._logLevel, 'Got {0} orphans', DisplayObjectUnloader._orphans.length);
				}

				DisplayObjectUnloader._orphans = null;
				DisplayObjectUnloader._recordOrphans = false;
			} else {
				DisplayObjectUnloader._recordOrphans = true;
			}
		}

		/**
		 * TODO: Check if the one frame loop works as intended
		 */
		private static function orphantEnterFrameHandler(event:Event):void
		{
			if (DisplayObjectUnloader._recordOrphans) {
				var id:String = (event.target.hasOwnProperty('uid')) ? event.target.uid : event.target.toString();
				var message:String = id;
				if (event.target.hasOwnProperty('numChildren')) message += ' :: ' + event.target.numChildren;
				if (event.target.hasOwnProperty('parent')) message += ' -> ' + (event.target.parent.hasOwnProperty('uid') ? event.target.parent.uid : event.target.parent.toString());
				if (DisplayObjectUnloader._orphans[id]) {
					LogManager.warn(DisplayObjectUnloader, 'Orphant {0} already exists!', id);
				} else {
					DisplayObjectUnloader._orphans[id] = message;
				}
			}
		}
	}
}