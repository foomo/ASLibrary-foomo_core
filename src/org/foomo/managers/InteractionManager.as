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
package org.foomo.managers
{
	import flash.display.DisplayObject;
	import flash.display.Stage;

	import org.foomo.core.Managers;

	[Event(name="change",type="flash.events.Event")]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class InteractionManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static initialization
		//-----------------------------------------------------------------------------------------

		Managers.registerClass('org.foomo.flash.managers::IInteractionManager', IInteractionManager);

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------


		//-----------------------------------------------------------------------------------------
		// ~ Static variables
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static var _impl:IInteractionManager;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton instance
		//-----------------------------------------------------------------------------------------

		private static function get impl():IInteractionManager
		{
			if (!_impl) _impl = IInteractionManager(Managers.getInstance("org.foomo.flash.managers::IInteractionManager"));
			return _impl;
		}

		public static function getInstance():IInteractionManager
		{
			return impl;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		public static function init(stage:Stage, delay:int):void
		{
			impl.init(stage, delay);
		}

		public static function get idle():Boolean
		{
			return impl.idle;
		}

		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			impl.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			impl.removeEventListener(type, listener, useCapture);
		}
	}
}