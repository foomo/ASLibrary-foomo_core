package org.foomo.flash.managers
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.System;

	import mx.managers.SystemManager;

	import org.foomo.flash.utils.ClassUtil;

	import spark.components.ComboBox;

	public class MemoryManagerImpl extends EventDispatcher
	{
		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private var _orphans:Array;

		private var _recordOrphans:Boolean = false;

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
			try {
				System.gc()
			} catch (e:Error) {
				var mem1:Number = System.totalMemory / 1024 / 1024;
				var diff:String = Number(mem0 - mem1).toFixed(2);
				LogManager.debug(MemoryMananager, 'Cleaned up {0} Mb of memory', diff);
			}
		}


		//-----------------------------------------------------------------------------------------
		// ~ Private static methods
		//-----------------------------------------------------------------------------------------

		private function applicationEnterFrameHandler(event:Event):void
		{
			if (this._recordOrphans) {
				var report:String = '';
				this._recordOrphans = false;

				SystemManager.getSWFRoot(this).addEventListener(Event.ENTER_FRAME, this.applicationEnterFrameHandler);

				report += '------------------------------------------------\n';
				report += 'Got ' + this._orphans.length + ' orphans';
				report += '------------------------------------------------';
				LogManager.debug(MemoryMananager, report);

				this._orphans = new Array;
				this._recordOrphans = true;
			}
		}

		public function orphantEnterFrameHandler(event:Event):void
		{
			if (this._recordOrphans) {
				var id:String = (event.target.hasOwnProperty('uid') ? event.target.uid : ClassUtil.getQualifiedName(event.target);
				if (event.target.hasOwnProperty('numChildren')) id += ' :: ' + event.target.numChildren;
				if (event.target.hasOwnProperty('parent')) id += ' -> ' + (event.target.parent.hasOwnProperty('uid') ? event.target.parent.uid : ClassUtil.getQualifiedName(event.target.parent));
				this._orphans.push(id);
			}
		}
	}
}