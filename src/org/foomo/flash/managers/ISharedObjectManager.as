package org.foomo.flash.managers
{
	public interface ISharedObjectManager
	{
		function get localIsAvailable():Boolean
		function get clientId():String
		function get sessionId():String
		function setLocalData(key:*, value:*):void
		function getLocalData(key:*):*
		function removeLocalData(key:*):*
		function flushLocal():String
	}
}