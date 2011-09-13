package org.foomo.utils
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
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
			_intervalCallbacks = new Dictionary();
			_invalidationCallbacks = new Dictionary();
			_callLaterObject.addEventListener(Event.ENTER_FRAME, CallLaterUtil.callLaterObject_enterFrameHandler);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private static var _callLaterObject:Shape;

		private static var _timeoutCallbacks:Dictionary;

		private static var _intervalCallbacks:Dictionary;

		private static var _invalidationCallbacks:Dictionary;

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * Call a method once on Event.ENTER_FRAME event.
		 * Note: If you call it twice, the arguements will be overwriten!
		 *
		 * @param callback Method to be invoked
		 * @param args Arguments to be passed
		 */
		public static function addCallback(callback:Function, ... args):void
		{
			_invalidationCallbacks[callback] = args;
		}

		/**
		 * Remove set callback
		 *
		 * @param callback Callback to be invoked
		 */
		public static function removeCallback(callback:Function):void
		{
			delete _invalidationCallbacks[callback];
		}

		/**
		 * Setting an timeout
		 *
		 * @param callback Method to be invoked
		 * @param delay Method call delay
		 * @param args Arguments to be passed
		 * @return Timeout id
		 */
		public static function setTimeout(callback:Function, delay:uint, ... args):uint
		{
			if (_timeoutCallbacks[callback]) CallLaterUtil.clearTimeout(callback);
			var id:uint = flash.utils.setTimeout(CallLaterUtil.timeoutCallback, delay, callback, args);
			_timeoutCallbacks[callback] = id;
			return id;
		}

		/**
		 * Clear a timeout
		 *
		 * @param callback Method to be invoked
		 */
		public static function clearTimeout(callback:Function):void
		{
			if (!_timeoutCallbacks[callback]) return;
			flash.utils.clearTimeout(_timeoutCallbacks[callback])
			delete _timeoutCallbacks[callback];
		}

		/**
		 * Setting an timeout interval
		 *
		 * @param callback Method to be invoked
		 * @param delay Method call delay
		 * @param args Arguments to be passed
		 * @return Timeout id
		 */
		public static function setInterval(callback:Function, delay:uint, ... args):uint
		{
			if (_intervalCallbacks[callback]) CallLaterUtil.clearTimeout(callback);
			var id:uint = flash.utils.setInterval(CallLaterUtil.intervalCallback, delay, callback, args);
			_intervalCallbacks[callback] = id;
			return id;
		}

		/**
		 * Clear an interval
		 *
		 * @param callback Method to be invoked
		 */
		public static function clearInterval(callback:Function):void
		{
			if (!_intervalCallbacks[callback]) return;
			flash.utils.clearTimeout(_intervalCallbacks[callback])
			delete _intervalCallbacks[callback];
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 * @private
		 */
		private static function callLaterObject_enterFrameHandler(event:Event):void
		{
			for (var key:Object in _invalidationCallbacks) {
				key.apply(null, _invalidationCallbacks[key]);
				delete _invalidationCallbacks[key];
			}
		}

		/**
		 * @private
		 */
		private static function timeoutCallback(callback:Function, args:Array=null):void
		{
			callback.apply(null, args);
		}

		/**
		 * @private
		 */
		private static function intervalCallback(callback:Function, args:Array=null):void
		{
			callback.apply(null, args);
		}
	}
}