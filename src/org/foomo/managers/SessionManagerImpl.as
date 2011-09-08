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
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	import flash.net.registerClassAlias;

	import org.foomo.utils.ClassUtil;
	import org.foomo.utils.UIDUtil;

	[ExcludeClass]

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 * @todo	Implement remote object
	 * @todo	Test object serialization
	 */
	public class SessionManagerImpl implements ISessionManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static var name:String = 'org.foomo.flash.managers.SessionManager';
		public static var localPath:String = null;
		public static var secure:Boolean = false;

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _sessionId:String;

		private var _localIsAvailable:Boolean;

		private var _localObject:Object;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 */
		private static var _instance:ISessionManager;

		/**
		 * @private
		 */
		public function SessionManagerImpl()
		{
			this._sessionId = UIDUtil.create();

			try {
				this._localObject = SharedObject.getLocal(name, localPath, secure);
				if (this.getLocalData(name) == null) this.setLocalData(name, UIDUtil.create());
				this._localObject.flush();
				this._localIsAvailable = true;
			} catch (e:Error) {
				this._localObject = {data:{}};
				this._localIsAvailable = false;
			}
		}

		/**
		 * @private
		 */
		public static function getInstance():ISessionManager
		{
			if (!_instance) _instance = new SessionManagerImpl();
			return _instance;
		}


		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Whether local shared
		 */
		public function get localIsAvailable():Boolean
		{
			return this._localIsAvailable;
		}

		/**
		 * Unique client id
		 */
		public function get clientId():String
		{
			return (this.localIsAvailable) ? this.getLocalData(name) as String : this.sessionId;
		}

		/**
		 * Unique client id
		 */
		public function get sessionId():String
		{
			return this._sessionId;
		}

		public function setLocalData(key:Object, value:*):*
		{
			key = (key is String) ? key : ClassUtil.getQualifiedName(key);
			return this._localObject.data[key] = value;
		}

		public function getLocalData(key:Object, defaultValue:*=null):*
		{
			key = (key is String) ? key : ClassUtil.getQualifiedName(key);
			if (this._localObject.data.hasOwnProperty(key)) {
				return this._localObject.data[key];
			} else if (defaultValue != null) {
				return defaultValue;
			} else {
				return null;
			}
		}

		public function removeLocalData(key:Object):*
		{
			key = (key is String) ? key : ClassUtil.getQualifiedName(key);
			if (!this._localObject.data.hasOwnProperty(key)) return null;
			var value:* = this._localObject.data[key];
			delete this._localObject.data[key];
			return value;
		}

		public function clearLocal():void
		{
			var clientId:String = this.clientId;
			if (this.localIsAvailable) {
				this._localObject.clear();
			} else {
				this._localObject = {data:{}}
			}
			this.setLocalData(name, clientId);
		}

		public function flushLocal():String
		{
			return (this.localIsAvailable) ? this._localObject.flush() : null;
		}
	}
}