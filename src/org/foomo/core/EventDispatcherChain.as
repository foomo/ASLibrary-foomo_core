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
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import org.foomo.managers.LogManager;
	import org.foomo.managers.MemoryMananager;
	import org.foomo.memory.IUnload;
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
	dynamic public class EventDispatcherChain extends Proxy implements IUnload
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------
		
		public static const LOCAL_VAR:String = '@local';
		
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		/**
		 * Storage for local variables 
		 */
		private static var _variables:Object;
		/**
		 * Current dispatch instance
		 */
		private var _dispatcher:IEventDispatcher;
		/**
		 * Pending event listeners to be attached
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
				callback.apply(instance, instance.extractArgs(event, callback.length, eventArgs, instance.replaceCustomArgsVariables(customArgs)));
			}

			return this.addDispatcherEventListener(type, fnc);
		}

		/**
		 * Set a host object's property on the given event type
		 * 
		 * @param type The event type
		 * @param host The property host
		 * @param property The property name
		 * @param eventArgs Event parameters that should be passed as arguements to the new chain instance
		 * @param customArgs Custom arguements to be passed to the new chain instance
		 * @return The new chain instance
		 */
		public function setOnEvent(type:String, host:Object, property:String, eventArg:String=null, customArg:*=null):EventDispatcherChain
		{
			var fnc:Function
			var instance:EventDispatcherChain = this;

			fnc = function(event:Event):void {
				var value:* = (eventArg) ? ObjectUtil.resolveValue(event, eventArg) : instance.replaceCustomArgVariable(customArg);
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
		 * Chain a new dispatcher instance on the given event type
		 * 
		 * @param type The event type
		 * @param dispatcher The new dispatcher instance class
		 * @param eventArgs Event parameters that should be passed as arguements to the new chain instance
		 * @param customArgs Custom arguements to be passed to the new chain instance
		 * @return The new chain instance
		 */		
		public function chainOn(type:String, dispatcher:Class, eventArgs:Array=null, ... customArgs):EventDispatcherChain
		{
			var fnc:Function;
			var clazz:Class = ClassUtil.getClass(this);
			var instance:EventDispatcherChain = this;
			var newInstance:EventDispatcherChain = new clazz;
			if (eventArgs == null) eventArgs = [];

			fnc = function(event:Event):void {
				if (LogManager.isDebug()) LogManager.debug(instance, 'Chaining on event {0}::{1} :: {2}', ClassUtil.getQualifiedName(event.target), type,  ClassUtil.getQualifiedName(dispatcher));
				newInstance.setDispatcher(dispatcher, newInstance.extractArgs(event, ClassUtil.getConstructorParameters(dispatcher).length, eventArgs, instance.replaceCustomArgsVariables(customArgs)));
				// @todo Unloading at this point means that you can actually only chain one operation to anothor
				instance.unload();
			}

			instance.addEventListener(type, fnc);
			return newInstance;
		}

		/**
		 * Store a local variable for later use for given event type
		 * 
		 * @param type The Event type
		 * @param name The local variable name
		 * @param eventArg Name of the event property to read in
		 * @param customArg Custom variable value
		 * @return The current chain instance
		 */
		public function storeVariable(type:String, name:String, eventArg:String=null, customArg:*=null):EventDispatcherChain
		{
			var fnc:Function
			var instance:EventDispatcherChain = this;
			
			fnc = function(event:Event):void {
				var value:* = (eventArg) ? ObjectUtil.resolveValue(event, eventArg) : instance.replaceCustomArgVariable(customArg);
				if (LogManager.isDebug()) LogManager.debug(instance, 'Storing variable on event {0}::{1} :: {2} = {3}', ClassUtil.getQualifiedName(event.target), type, name, value);
				EventDispatcherChain._variables[name] = value;
			}			
			
			return this.addDispatcherEventListener(type, fnc);
		}
	
		/**
		 * Unload the chain on given event type
		 * 
		 * @param type The Event type
		 * @return The current chain instance
		 */
		public function unloadOnEvent(type:String):EventDispatcherChain
		{
			return this.addDispatcherEventListener(type, this.unloadHandler);
		}

		/**
		 * Unload the chain
		 */
		public function unload():void
		{
			this.removeAllListeners();
			this._pendingEventListeners = null;
			MemoryMananager.unload(this._dispatcher);
			this._dispatcher = null;
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
			MemoryMananager.unload(this);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

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
		
		/**
		 * Replace an array of values with local variables
		 * 
		 * @param values The array of values to be replaced 
		 * @return The replaced values array
		 */		
		flash_proxy function replaceCustomArgsVariables(values:Array):Array
		{
			for (var i:int=0; i < values.length; i++) values[i] = this.replaceCustomArgVariable(values[i])
			return values;
		}
		
		/**
		 * Replace a value with a local variable if required
		 * 
		 * @param value The value to be replaced
		 * @return The replaced value
		 */		
		flash_proxy function replaceCustomArgVariable(value:*):*
		{
			if (!value || !(value is String) || String(value).substr(0, 6) != EventDispatcherChain.LOCAL_VAR) return value;
			return ObjectUtil.resolveValue(EventDispatcherChain._variables, String(value).substr(EventDispatcherChain.LOCAL_VAR.length + 1));
		}

		//-----------------------------------------------------------------------------------------
		// ~ Protected static methods
		//-----------------------------------------------------------------------------------------
	
		protected static function resetVariables():void
		{
			EventDispatcherChain._variables = {}
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
			EventDispatcherChain.resetVariables();
			return ret.setDispatcher(dispatcher, args);
		}
	}
}