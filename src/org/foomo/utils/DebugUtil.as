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
	import flash.utils.describeType;

	import org.foomo.logging.LogLevel;
	import org.foomo.managers.LogManager;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class DebugUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static var MAX_EXPORT_LEVEL:uint = 5;

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Returns a human readable object description
		 * Note: you should not use this in production mode as it costs time to reflect
		 */
		public static function export(obj:Object):String
		{
			return DebugUtil.recursiveExport(obj).substr(0, -1);
		}

		/**
		 * Logs a human readable object description
		 * Note: you should not use this in production mode as it costs time to reflect
		 */
		public static function dump(obj:Object, level:int=LogLevel.DEBUG):void
		{
			if (LogManager.isLevel(level)) LogManager.log(DebugUtil, level, DebugUtil.export(obj));
		}

		/**
		 * Returns lines of the stack trace
		 * Note: Works only for the debug player
		 */
		public static function getStackTrace(startIndex:int=0, endIndex:int=-1):String
		{
			var stackTrace:String	= '';
			var stackData:Array		= DebugUtil.getStackTraceData(startIndex, endIndex);
			while (stackData.length > 0) stackTrace += stackData.shift() + '\n';
			return stackTrace;
		}

		/**
		 * Returns data of the stack trace
		 * Note: Works only for the debug player
		 */
		public static function getStackTraceData(startIndex:int=0, endIndex:int=-1):Array
		{
			var stack:Array = new Array;
			try {
				throw new Error();
			} catch (error: Error) {
				var stackTrace:String 	= error.getStackTrace();
				var stackData:Array		= stackTrace.split('\n');
				stack 					= stackData.slice(startIndex, endIndex);
			}
			return stack;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static function recursiveExport(obj:Object, level:int=0):String
		{
			if (level == MAX_EXPORT_LEVEL) return '...\n';

			var prop:Object;
			var export:String = '';
			var type:String = typeof(obj);
			var className:String = ClassUtil.getQualifiedName(obj);

			switch (className) {
				case 'int':
				case 'Number':
				case 'Boolean':
					export += className + " " + formatType(obj, className) + '\n';
					break;
				case 'String':
					export += className + " " + formatType(obj, className) + " (length=" + (obj as String).length + ")\n";
					break;
				case 'XML':
				case 'XMLList':
					export += className + "\n" + obj.toXMLString() + "\n";
					break;
				case 'Array':
				case 'Object':
					var count:int = 0;
					for (prop in obj) {
						export += formatType(prop, ClassUtil.getQualifiedName(prop)) + ' => ' + recursiveExport(obj[prop], level + 1);
						count++;
					}
					export = formatType(obj, className) + ' {\n' + indent(export.substr(0, -1)) + '\n} (length=' + count + ')\n';
					break;
				default:
					if (type == 'object') {
						var propXML:XML
						var objDescription:XML = describeType(obj);
						for each (propXML in objDescription..variable) export += "'" + propXML.@type.toXMLString() + "'" + ' => ' + recursiveExport(obj[propXML.@type.toXMLString()], level + 1);
						for each (propXML in objDescription..accessor) if (propXML.access != 'writeonly') export += "'" + propXML.@name.toXMLString() + "'" + ' => ' + recursiveExport(obj[propXML.@name.toXMLString()], level + 1);
						export = formatType(obj, className) + '\n' + indent(export.substr(0, -1)) + '\n';
					} else {
						LogManager.warn(LogManager, 'Unhandled type: {0} | {1}', type, className);
					}
					break;
			}

			return export;
		}

		private static function formatType(obj:Object, className:String):String
		{
			switch (className) {
				case 'int':
				case 'Number':
				case 'Boolean':
					return obj + '';
					break;
				case 'String':
					return "'" + obj + "'"
					break;
				case 'Array':
				case 'Object':
					return className
					break;
				default:
					return "'" + className + "'"
					break;
			}
		}

		private static function indent(lines:String, repeat:int=1):String
		{
			var ret:Array = new Array;
			for each (var line:String in lines.split('\n')) ret.push(StringUtil.prepend(line, '    ', repeat));
			return ret.join('\n');
		}

		/**
		 * @private
		 * Internal function to get the number of children from the object - getting only the first level
		 */
		private static function getLength(o:Object):uint
		{
			var len:uint = 0;
			for (var item:* in o)
				len++;
			return len;
		}
	}
}