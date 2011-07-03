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
package org.foomo.flash.managers
{
	import flash.events.IEventDispatcher;

	import org.foomo.flash.logging.ILoggingTarget;

	[Event(name="log", type="org.foomo.flash.events.LogManagerEvent")]

	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	public interface ILogManager extends IEventDispatcher
	{
		function get level():int
		function set level(value:int):void
		function isDebug():Boolean
		function isInfo():Boolean
		function isWarn():Boolean
		function isError():Boolean
		function isFatal():Boolean
		function removeLoggingTarget(target:*):Boolean;
		function addLoggingTarget(target:ILoggingTarget):String
		function log(category:*, level:int, message:String, parameters:Array):void;
	}
}