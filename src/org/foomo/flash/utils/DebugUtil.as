package org.foomo.flash.utils
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	import mx.utils.ObjectUtil;


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
		 */
		public static function export(obj:Object):String
		{
			return DebugUtil.recursiveExport(obj).substr(0, -1);
		}

		/**
		 * Returns lines of the stack trace
		 * Note: Works only for the debug player
		 */
		public static function getStackTrace(startIndex:int=0, endIndex:int=-1):String
		{
			var stackTrace:String	= '';
			var stackData:Array		= DebugUtil.getStackTraceData(startIndex, endIndex);
			while (stackData.length > 0) {
				stackTrace += stackData.shift() + '\n';
			}
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
				case 'Array':
				case 'Object':
					for (prop in obj) export += formatType(prop, ClassUtil.getQualifiedName(prop)) + ' => ' + recursiveExport(obj[prop], level + 1);
					export = formatType(obj, className) + ' {\n' + indent(export.substr(0, -1)) + '\n}\n';
					break;
				default:
					if (type == 'object') {
						var propList:XMLList = describeType(obj)..variable;
						for (var i:int; i<propList.length(); i++){
							prop = obj[propList[i].@name];
							export += "'" + propList[i].@name + "'" + ' => ' + recursiveExport(prop, level + 1);
						}
						export = formatType(obj, className) + '\n' + indent(export.substr(0, -1)) + '\n';
					} else {
						trace('Unhandled type:', type, className);
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