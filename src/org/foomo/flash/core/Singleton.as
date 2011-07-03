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
package org.foomo.flash.core
{
	/**
	 * This class is inspired by flex framework as if gives you the possibility
	 * to overwrite singletons in the preinitialization process.
	 *
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 * @see mx.core.Singleton
	 */
	public class Singleton
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 */
		private static var classMap:Object = {};

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *  Register class for interface name
		 */
		public static function registerClass(interfaceName:String, clazz:Class):void
		{
			if (!classMap[interfaceName]) classMap[interfaceName] = clazz;
		}

		/**
		 *  Get class by interface name
		 */
		public static function getClass(interfaceName:String):Class
		{
			return classMap[interfaceName];
		}

		/**
		 *  Returns the singleton instance for a given interface name
		 */
		public static function getInstance(interfaceName:String):Object
		{
			var c:Class = classMap[interfaceName];
			if (!c) throw new Error("No class registered for interface '" + interfaceName + "'.");
			return c["getInstance"]();
		}
	}
}