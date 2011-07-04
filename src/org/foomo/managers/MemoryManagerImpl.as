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
	import flash.events.ErrorEvent;
	import flash.system.System;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	import org.foomo.memory.IUnloader;
	import org.foomo.utils.ClassUtil;

	[ExcludeClass]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class MemoryManagerImpl implements IMemoryManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _unloader:Array = new Array;
		private var _unloaderCache:Array = new Array;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 */
		private static var _instance:IMemoryManager;

		/**
		 * @private
		 */
		public function MemoryManagerImpl()
		{
		}

		/**
		 * @private
		 */
		public static function getInstance():IMemoryManager
		{
			if (!_instance) _instance = new MemoryManagerImpl();
			return _instance;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Forces garbage collection and log debug info
		 */
		public function gc():void
		{
			var mem0:Number = (System.totalMemory / 1024 / 1024);
			var mem1:Number;
			var diff:String;

			try {
				System.gc()
				mem1 = System.totalMemory / 1024 / 1024;
				diff = Number(mem0 - mem1).toFixed(2);
				LogManager.debug(MemoryMananager, 'Cleaned up {0} Mb of memory', diff);
			} catch (e:Error) {
				mem1 = System.totalMemory / 1024 / 1024;
				diff = Number(mem0 - mem1).toFixed(2);
				LogManager.warn(MemoryMananager, 'Could not clear memory! Cleared {0} Mb of memory', diff);
			}
		}

		public function addUnloader(type:*, unloader:IUnloader):void
		{
			type = (type is String) ? type : getQualifiedClassName(type);
			this._unloader[type] = unloader;
			this._unloaderCache = new Array;
		}

		public function removeUnloader(type:*):void
		{
			type = (type is String) ? type : getQualifiedClassName(type);
			delete this._unloader[type];
			this._unloaderCache = new Array;
		}

		public function unload(obj:Object):void
		{
			var objClassName:String
			var objUnloaderExists:Boolean = false;
			var objName:String = getQualifiedClassName(obj);

			// cache objects if neede
			if (!this._unloaderCache[objName]) {
				this._unloaderCache[objName] = new Array;
				var propXML:XML;
				var objDescription:XML = describeType(obj);
				var objClassNames:Array = new Array;
				for each (propXML in objDescription..implementsInterface) objClassNames.push(propXML.@type.toXMLString());
				objClassNames.push(objName);
				for each (propXML in objDescription..extendsClass) objClassNames.push(propXML.@type.toXMLString());
				for each (objClassName in objClassNames) {
					if (this._unloader[objClassName]) {
						try {
							IUnloader(this._unloader[objClassName]).unload(obj);
							this._unloaderCache[objName].push(objClassName);
						} catch (e:ErrorEvent) {
							LogManager.warn(MemoryMananager, 'Could not unload {0} with {1}', objClassName, getQualifiedClassName(this._unloader[objClassName]));
						}
					}
				}
			} else {
				for each (objClassName in this._unloaderCache[objName]) {
					if (this._unloader[objClassName]) {
						try {
							IUnloader(this._unloader[objClassName]).unload(obj);
						} catch (e:ErrorEvent) {
							LogManager.warn(MemoryMananager, 'Could not unload {0} with {1}', objClassName, getQualifiedClassName(this._unloader[objClassName]));
						}
					}
				}
			}
		}
	}
}