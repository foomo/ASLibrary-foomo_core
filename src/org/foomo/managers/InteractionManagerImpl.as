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
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	[Event(name="change",type="flash.events.Event")]

	internal class InteractionManagerImpl extends EventDispatcher implements IInteractionManager
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _idle:Boolean = false;

		private var _timer:Timer;

		//-----------------------------------------------------------------------------------------
		// ~ Singleton constructor
		//-----------------------------------------------------------------------------------------

		/**
		 *  @private
		 */
		private static var _instance:IInteractionManager;

		/**
		 * @private
		 */
		public function InteractionManagerImpl()
		{
		}

		/**
		 * @private
		 */
		public static function getInstance():IInteractionManager
		{
			if (!_instance) _instance = new InteractionManagerImpl();
			return _instance;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public function init(stage:Stage, delay:int):void
		{
			this._timer = new Timer(delay, 1);
			this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.timerCompleteHandler);

			stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.interactionHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, this.interactionHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, this.interactionHandler);
			stage.addEventListener(Event.MOUSE_LEAVE, this.mouseLeaveHandler);
			stage.addEventListener(MouseEvent.CLICK, this.interactionHandler);
		}

		[Bindable(event="change")]
		public function get idle():Boolean
		{
			return this._idle;
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private eventhandler
		//-----------------------------------------------------------------------------------------

		private function interactionHandler(event:Event):void
		{
			this.setIdle(false);
			this._timer.reset();
			this._timer.start();
		}

		private function mouseLeaveHandler(event:Event):void
		{
			this.setIdle(true);
		}

		private function timerCompleteHandler(event:TimerEvent):void
		{
			this.setIdle(true);
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private methods
		//-----------------------------------------------------------------------------------------

		private function setIdle(value:Boolean):void
		{
			if (this._idle == value) return;
			this._idle = value;
			this.dispatchEvent(new Event(Event.CHANGE));
		}
	}
}