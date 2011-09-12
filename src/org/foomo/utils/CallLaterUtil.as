package org.foomo.utils
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class CallLaterUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Static initialization
		//-----------------------------------------------------------------------------------------

		private static var staticInitialization:Object
		{
			_callLaterObject = new Shape;
			_timeoutCallbacks = new Dictionary();
			_invalidationCallbacks = new Dictionary();
			_callLaterObject.addEventListener(Event.ENTER_FRAME, CallLaterUtil.callLaterObject_enterFrameHandler);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private static var _callLaterObject:Shape;

		private static var _timeoutCallbacks:Dictionary;

		private static var _invalidationCallbacks:Dictionary;

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		public static function addCallback(callback:Function, ... args):void
		{
			_invalidationCallbacks[callback] = args;
		}

		public static function removeCallback(callback:Function):void
		{
			delete _invalidationCallbacks[callback];
		}

		public static function setTimeout(callback:Function, delay:uint, ... args):uint
		{
			if (_timeoutCallbacks[callback]) CallLaterUtil.clearTimeout(callback);
			var id:uint = flash.utils.setTimeout(CallLaterUtil.timeoutCallback, delay, callback, args);
			_timeoutCallbacks[callback] = id;
			return id;
		}

		public static function clearTimeout(callback:Function):void
		{
			if (!_timeoutCallbacks[callback]) return;
			flash.utils.clearTimeout(_timeoutCallbacks[callback])
			delete _timeoutCallbacks[callback];
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		private static function callLaterObject_enterFrameHandler(event:Event):void
		{
			for (var key:Object in _invalidationCallbacks) {
				key.apply(null, _invalidationCallbacks[key]);
				delete _invalidationCallbacks[key];
			}
		}

		private static function timeoutCallback(callback:Function, args:Array=null):void
		{
			callback.apply(null, args);
		}
	}
}