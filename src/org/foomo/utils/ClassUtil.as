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
	import flash.net.registerClassAlias;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	public class ClassUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static variables
		//-----------------------------------------------------------------------------------------

		private static var getConstructorParameterLengthCache:Array = [];

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param value		The object for which a fully qualified class name is desired. Any ActionScript value may be passed to this method including all available ActionScript types, object instances, primitive types such as uint, and class objects
		 * @return 			A string containing the fully qualified class name
		 */
		public static function getQualifiedName(value:*):String
		{
			return getQualifiedClassName(value).replace('::', '.');
		}

		/**
		 *
		 */
		public static function getPackageName(value:*):String
		{
			var data:Array = getQualifiedName(value).split('.').pop();
			return (data.length > 0) ? data.join('.') : 'default';
		}

		/**
		 *
		 */
		public static function getClass(value:*):Class
		{
			return (value != null) ? getDefinitionByName(ClassUtil.getQualifiedName(value)) as Class : null;
		}

		/**
		 * @todo chache
		 */
		public static function getClassName(value:*):String
		{
			return getQualifiedName(value).split('.').pop();
		}

		/**
		 *
		 */
		public static function callMethod(instance:Object, method:String, args:Array=null):*
		{
			if (!instance.hasOwnProperty(method) || !(instance[method] is Function)) throw new Error('No method ' + method + 'on  instance');
			var func:Function = (instance[method] as Function);
			return func.apply(instance, args);
		}

		/**
		 *
		 */
		public static function callMethodIfType(instance:Object, type:Class, method:String, args:Array=null):*
		{
			if (!(instance is type)) return null;
			return ClassUtil.callMethod(instance, method, args);
		}

		/**
		 *
		 */
		public static function createInstance(clazz:Class, args:Array=null):*
		{
			if (args == null) args = [];
			switch (args.length) {
				case 0:
					return new clazz();
					break;
				case 1:
					return new clazz(args[0]);
					break;
				case 2:
					return new clazz(args[0], args[1]);
					break;
				case 3:
					return new clazz(args[0], args[1], args[2]);
					break;
				case 4:
					return new clazz(args[0], args[1], args[2], args[3]);
					break;
				case 5:
					return new clazz(args[0], args[1], args[2], args[3], args[4]);
					break;
				case 6:
					return new clazz(args[0], args[1], args[2], args[3], args[4], args[5]);
					break;
				case 7:
					return new clazz(args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
					break;
				case 8:
					return new clazz(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]);
					break;
				case 9:
					return new clazz(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]);
					break;
				case 10:
					return new clazz(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]);
					break;
				default:
					throw new Error('Too many arguments! Please update me self!');
					break;
			}
		}

		/**
		 *
		 */
		public static function getConstructorParameters(clazz:Class):Array
		{
			var clazzName:String = ClassUtil.getQualifiedName(clazz);
			if (ClassUtil.getConstructorParameterLengthCache[clazzName]) return ClassUtil.getConstructorParameterLengthCache[clazzName];
			var parameters:Array = [];
			var clazzDescription:XML = describeType(clazz);
			for each (var item:XML in clazzDescription..constructor.parameter) parameters.push(item.@type.toXMLString().replace('::', '.'));
			ClassUtil.getConstructorParameterLengthCache[clazzName] = parameters;
			return ClassUtil.getConstructorParameterLengthCache[clazzName];
		}

		/**
		 *
		 */
		public static function registerClass(clazz:Class):void
		{
			registerClassAlias(getQualifiedName(clazz), clazz);
		}
	}
}