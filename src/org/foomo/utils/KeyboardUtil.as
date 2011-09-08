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
	import flash.display.InteractiveObject;
	import flash.events.KeyboardEvent;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 * @todo	check weak binding
	 */
	public class KeyboardUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public static function addKeyCodeCallback(caller:InteractiveObject, callback:Function, keyCode:int, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false, ... args):void
		{
			caller.addEventListener(KeyboardEvent.KEY_DOWN, EventHandlerUtil.addCallback(caller_keyDownHandler, ['keyCode', 'ctrlKey', 'altKey', 'shiftKey'], callback, keyCode, ctrlKey, altKey, shiftKey, args));
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		private static function caller_keyDownHandler(eventKeyCode:uint, eventCtrlKey:Boolean, eventAltKey:Boolean, eventShifKey:Boolean, callback:Function, keyCode:uint, ctrlKey:Boolean, altKey:Boolean, shifKey:Boolean, args:Array):void
		{
			if (eventKeyCode == keyCode && eventCtrlKey == ctrlKey && eventAltKey  == altKey && eventShifKey == shifKey) callback.apply(null, args);
		}
	}
}