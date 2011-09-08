package org.foomo.utils
{
	import org.foomo.managers.LogManager;

	public class ObjectUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param host the object containing the value
		 * @param path sth. like path.to.the.value
		 */
		public static function resolveValue(host:Object, path:String):*
		{
			var pathItem:*;
			var value:Object = host;
			var pathItems:Array = path.split('.');
			while (pathItem = pathItems.shift()) {
				try  {
					value = value[pathItem];
				} catch (e:Error) {
					if (LogManager.isFatal()) LogManager.fatal(ObjectUtil, 'Could not resolve {0} on {1}', path, ClassUtil.getQualifiedName(host));
					value = null;
				}
			}
			return value;
		}

		/**
		 *
		 */
		public static function isClass(obj:Object, clazzes:Array):Boolean
		{
			for each (var clazz:Class in clazzes) {
				if (obj is clazz) return true;
			}
			return false;
		}
	}
}