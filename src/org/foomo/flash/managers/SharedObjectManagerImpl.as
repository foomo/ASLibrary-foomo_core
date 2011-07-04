package org.foomo.flash.managers
{
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;

	import org.foomo.flash.utils.UIDUtil;

	public class SharedObjectManagerImpl implements ISharedObjectManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		public static var SESSION_NAME:String = 'org.foomo.flash.managers.SessionManager';
		public static var STORAGE_PATH:String = '/';
		public static var SECURE:Boolean = true;

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _sessionId:String;

		private var _localIsAvailable:Boolean;

		private var _localObject:SharedObject;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 */
		private static var _instance:ISharedObjectManager;

		/**
		 * @private
		 */
		public function SharedObjectManagerImpl()
		{
			this._sessionId = UIDUtil.create();

			try {
				this._localObject = SharedObject.getLocal(SESSION_NAME, STORAGE_PATH, SECURE);
				if (!this._localObject.hasOwnProperty('clientId')) this._localObject.data.__clientId = UIDUtil.create();
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
		public static function getInstance():ISharedObjectManager
		{
			if (!_instance) _instance = new MemoryManagerImpl();
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
			return (this.localIsAvailable) ? this._localObject.data.__clientId : this.sessionId;
		}

		/**
		 * Unique client id
		 */
		public function get sessionId():String
		{
			return this._sessionId;
		}

		public function setLocalData(key:*, value:*):void
		{
			this._localObject.data[key] = value;
		}

		public function getLocalData(key:*):*
		{
			return this._localObject.data[key];
		}

		public function removeLocalData(key:*):*
		{
			var value:* = this._localObject.data[key];
			delete this._localObject.data[key];
			return value;
		}

		public function flushLocal():String
		{
			return (this.localIsAvailable) ? this._localObject.flush() : null;
		}
	}
}