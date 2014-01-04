package org.foomo.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class Foomo extends EventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static Variables
		//-----------------------------------------------------------------------------------------

		protected static var instances:Dictionary = new Dictionary;

		public static var defaultServerUrl:String = '';

		public static var defaultFoomoPath:String = '/foomo';

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _serverUrl:String;

		private var _foomoPath:String;

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		public function Foomo(serverUrl:String, foomoPath:String)
		{
			this._serverUrl = serverUrl;
			this._foomoPath = foomoPath;
			this.dispatchEvent(new Event(Event.CHANGE));
		}

		public static function getInstance(serverUrl:String=null, foomoPath:String=null):Foomo
		{
			if (serverUrl == null) serverUrl = Foomo.defaultServerUrl;
			if (foomoPath == null) foomoPath = Foomo.defaultFoomoPath;
			var foomoUrl:String = serverUrl + foomoPath;
			if (instances[foomoUrl]) return instances[foomoUrl];
			return instances[foomoUrl] = new Foomo(serverUrl, foomoPath);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		[Bindable(event="change")]
		public function get serverUrl():String
		{
			return this._serverUrl;
		}

		[Bindable(event="change")]
		public function get foomoPath():String
		{
			return this._foomoPath;
		}

		[Bindable(event="change")]
		public function get foomoUrl():String
		{
			return this._serverUrl + this._foomoPath;
		}

		[Bindable(event="change")]
		public function getModuleHtdocsPath(moduleName:String):String
		{
			return this.foomoPath + '/modules/' + moduleName;
		}

		[Bindable(event="change")]
		public function getModuleHtdocsUrl(moduleName:String):String
		{
			return this.serverUrl + this.getModuleHtdocsPath(moduleName);
		}

		[Bindable(event="change")]
		public function getModuleHtdocsVarPath(moduleName:String):String
		{
			return this.foomoPath + '/modulesVar/' + moduleName;
		}

		[Bindable(event="change")]
		public function getModuleHtdocsVarUrl(moduleName:String):String
		{
			return this.serverUrl + this.getModuleHtdocsVarPath(moduleName);
		}

		[Bindable(event="change")]
		public function getServiceEndPointPath(moduleName:String, endPoint:String='frontend'):String
		{
			return this.getModuleHtdocsPath(moduleName) + '/services/' + endPoint + '.php/Foomo.Services.RPC/serve';
		}

		[Bindable(event="change")]
		public function getServiceEndPointUrl(moduleName:String, endPoint:String='frontend'):String
		{
			return this.serverUrl + '/' + this.getServiceEndPointPath(moduleName, endPoint);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param endPointUrl the handling .php file
		 * @param className the controllers identifier
		 * @param actionName the action name i.e. "getContent"
		 * @param parms name => value i.e. "contentId" => "209234fkkflakgh4l4"
		 */
		protected function getControllerHelperUrl(endPointUrl:String, className:String, actionName:String='actionDefault', parms:Object=null):String
		{
			var data:Array = [];
			for (var key:String in parms) {
				if (parms[key] == null || parms[key] == '') continue;
				data.push(key + '=' + parms[key]);
			}
			return endPointUrl + '?class=' + className + '&action=' + actionName + '&' + data.join('&');
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		[Bindable(event="change")]
		public static function getModuleHtdocsPath(moduleName:String, serverUrl:String=null, foomoPath:String=null):String
		{
			return Foomo.getInstance(serverUrl, foomoPath).getModuleHtdocsPath(moduleName);
		}

		[Bindable(event="change")]
		public static function getModuleHtdocsUrl(moduleName:String, serverUrl:String=null, foomoPath:String=null):String
		{
			return Foomo.getInstance(serverUrl, foomoPath).getModuleHtdocsUrl(moduleName);
		}

		[Bindable(event="change")]
		public static function getModuleHtdocsVarPath(moduleName:String, serverUrl:String=null, foomoPath:String=null):String
		{
			return Foomo.getInstance(serverUrl, foomoPath).getModuleHtdocsVarPath(moduleName);
		}

		[Bindable(event="change")]
		public static function getModuleHtdocsVarUrl(moduleName:String, serverUrl:String=null, foomoPath:String=null):String
		{
			return Foomo.getInstance(serverUrl, foomoPath).getModuleHtdocsVarUrl(moduleName);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @param endPointUrl the handling .php file
		 * @param className the controllers identifier
		 * @param actionName the action name i.e. "getContent"
		 * @param rest name => value i.e. "contentId", 209234fkkflakgh4l4, ...
		 */
		protected static function getControllerHelperUrl(endPointUrl:String, className:String, actionName:String='default', parms:Object=null, serverUrl:String=null, foomoPath:String=null):String
		{
			return Foomo.getInstance(serverUrl, foomoPath).getControllerHelperUrl(endPointUrl, className, actionName, parms);
		}
	}
}