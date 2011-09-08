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
package org.foomo.core
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.sampler.getSavedThis;
	import flash.utils.Proxy;
	import flash.utils.describeType;
	import flash.utils.flash_proxy;

	import org.foomo.managers.LogManager;
	import org.foomo.utils.ClassUtil;
	import org.foomo.utils.ObjectUtil;
	import org.foomo.utils.StringUtil;

	use namespace flash_proxy;

	/**
	 * @todo 	use describe tpye to find all events
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	dynamic public class EventDispatcherChain extends Proxy
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private var _dispatcher:IEventDispatcher;
		/**
		 *
		 */
		private var _pendingEventListeners:Array = [];
		/**
		 *
		 */
		private var _dispatcherEventListeners:Array = [];

		//-----------------------------------------------------------------------------------------
		// ~ Constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function EventDispatcherChain()
		{
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public function addEventCallback(type:String, callback:Function, eventArgs:Array=null, ... customArgs):EventDispatcherChain
		{
			var fnc:Function
			var instance:EventDispatcherChain = this;
			if (eventArgs == null) eventArgs = [];

			fnc = function(event:Event):void {
				if (LogManager.isDebug()) LogManager.debug(instance, 'Adding callback on event {0}::{1} :: callback({2})', ClassUtil.getQualifiedName(event.target), type, customArgs);
				callback.apply(instance, instance.extractArgs(event, callback.length, eventArgs, customArgs));
			}

			return this.addDispatcherEventListener(type, fnc);
		}

		/**
		 *
		 */
		public function setOnEvent(type:String, host:Object, property:String, eventArg:String=null, customArg:*=null):EventDispatcherChain
		{
			var fnc:Function
			var instance:EventDispatcherChain = this;

			fnc = function(event:Event):void {
				var value:* = (eventArg) ? ObjectUtil.resolveValue(event, eventArg) : customArg;
				if (LogManager.isDebug()) LogManager.debug(instance, 'Setting value on event {0}::{1} :: {2}::{3} = {4}', ClassUtil.getQualifiedName(event.target), type, ClassUtil.getQualifiedName(host), property, value);
				host[property] = value;
			}

			return this.addDispatcherEventListener(type, fnc);
		}

		/**
		 *
		 */
		public function addEventListener(type:String, listener:Function):EventDispatcherChain
		{
			return this.addDispatcherEventListener(type, listener);
		}

		/**
		 *
		 */
		public function removeEventListener(type:String, listener:Function):EventDispatcherChain
		{
			return this.removeDispatcherEventListener(type, listener);
		}

		/**
		 *
		 */
		public function chainOn(type:String, dispatcher:Class, eventArgs:Array=null, ... rest):EventDispatcherChain
		{
			var fnc:Function;
			var clazz:Class = ClassUtil.getClass(this);
			var instance:EventDispatcherChain = this;
			var newInstance:EventDispatcherChain = new clazz;
			if (eventArgs == null) eventArgs = [];

			fnc = function(event:Event):void {
				if (LogManager.isDebug()) LogManager.debug(instance, 'Chaining on event {0}::{1} :: {2}', ClassUtil.getQualifiedName(event.target), type,  ClassUtil.getQualifiedName(dispatcher));
				newInstance.setDispatcher(dispatcher, newInstance.extractArgs(event, ClassUtil.getConstructorParameters(dispatcher).length, eventArgs, rest));
				instance.unload();
			}

			instance.addEventListener(type, fnc);
			return newInstance;
		}

		/**
		 *
		 */
		public function unloadOnEvent(type:String):EventDispatcherChain
		{
			return this.addDispatcherEventListener(type, this.unloadHandler);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Overriden methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @inherit
		 */
		flash_proxy override function callProperty(name:*, ...rest):*
		{
			var type:String;
			var method:String = QName(name).localName;
			switch (true) {
				case (method.substr(0, 3) == 'add' && method.substr(-8) == 'Callback'):
					type = StringUtil.lcFirst(method.substring(3, method.length-8));
					rest.unshift(type);
					return (this.addEventCallback as Function).apply(this, rest);
					break;
				case (method.substr(0, 3) == 'add' && method.substr(-8) == 'Listener'):
					type = StringUtil.lcFirst(method.substring(3, method.length-8));
					rest.unshift(type);
					return (this.addEventListener as Function).apply(this, rest);
					break;
				case (method.substr(0, 7) == 'chainOn'):
					type = StringUtil.lcFirst(method.substring(7));
					rest.unshift(type);
					var x:* = this.chainOn;
					return (this.chainOn as Function).apply(this, rest);
					break;
				case (method.substr(0, 8) == 'unloadOn'):
					type = StringUtil.lcFirst(method.substring(8));
					return (this.unloadOnEvent as Function).apply(this, [type]);
					break;
			}
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		private function unloadHandler(event:Event):void
		{
			this.unload();
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		flash_proxy function unload():void
		{
			this.removeAllDispatcherListeners();
			this._pendingEventListeners = null;
			this._dispatcher = null;
		}

		/**
		 *
		 */
		flash_proxy function setDispatcher(dispatcher:Class, args:Array):EventDispatcherChain
		{
			var obj:Object
			this._dispatcher = ClassUtil.createInstance(dispatcher, args);
			while (obj = this._pendingEventListeners.shift()) this.addDispatcherEventListener(obj.type, obj.listener);
			return this;
		}

		/**
		 *
		 */
		flash_proxy function extractArgs(event:Event, methodCount:int, eventArgs:Array, rest:Array):Array
		{
			var ret:Array = rest.concat();
			for (var i:int = eventArgs.length - 1; i >= 0; i--) {
				ret.unshift(ObjectUtil.resolveValue(event, eventArgs[i]));
			}
			return ret;
		}

		/**
		 *
		 */
		flash_proxy function addDispatcherEventListener(type:String, listener:Function):EventDispatcherChain
		{
			if (this._dispatcher) {
				this._dispatcherEventListeners.push({type:type, listener:listener});
				this._dispatcher.addEventListener(type, listener);
			} else {
				this._pendingEventListeners.push({type:type, listener:listener});
			}
			return this;
		}

		/**
		 *
		 */
		flash_proxy function removeDispatcherEventListener(type:String, listener:Function):EventDispatcherChain
		{
			var obj:Object;
			var newListereners:Array = [];
			if (this._dispatcher) {
				for each (obj in this._dispatcherEventListeners) if (obj.type != type || obj.listener != listener) newListereners.push(obj);
				this._dispatcherEventListeners = newListereners;
				this._dispatcher.removeEventListener(type, listener);
			} else {
				for each (obj in this._pendingEventListeners) if (obj.type != type || obj.listener != listener) newListereners.push(obj);
				this._pendingEventListeners = newListereners;
			}
			return this;
		}

		/**
		 *
		 */
		flash_proxy function removeAllListeners():EventDispatcherChain
		{
			var obj:Object
			while (obj = this._dispatcherEventListeners.shift()) this._dispatcher.removeEventListener(obj.type, obj.listener);
			obj = null;
			return this;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------

		/**
		 *
		 */
		public static function create(dispatcher:Class, ... args):EventDispatcherChain
		{
			if (LogManager.isDebug()) LogManager.debug(EventDispatcherChain, 'Creating EventDispatcherChain :: {0}', ClassUtil.getQualifiedName(dispatcher));
			var ret:EventDispatcherChain = new EventDispatcherChain();
			return ret.setDispatcher(dispatcher, args);
		}
	}
}