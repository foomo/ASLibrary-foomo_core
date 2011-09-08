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
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class EventHandlerUtil extends EventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public static function addCallback(callback:Function, eventArgs:Array=null, ... args):Function
		{
			var ret:Function;
			if (eventArgs == null) eventArgs = [];

			ret = function(e:Event):void {
				var ret:Array = args.concat();
				for (var i:int = eventArgs.length - 1; i >= 0; i--) ret.unshift(ObjectUtil.resolveValue(e, eventArgs[i]));
				callback.apply(null, ret);
			};

			return ret;
		}

		public static function setOn(host:Object, property:String, eventArg:String=null, customArg:*=null):Function
		{
			var ret:Function;

			ret = function(e:Event):void {
				host[property] = (eventArg) ? ObjectUtil.resolveValue(e, eventArg) : customArg;
			};

			return ret;
		}
	}
}