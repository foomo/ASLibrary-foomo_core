package org.foomo.flash.managers
{
	public interface ISessionManager
	{
		function get localIsAvailable():Boolean
		function get clientId():String
		function get sessionId():String
		function setLocalData(key:Object, value:*):*
		function getLocalData(key:Object, defaultValue:*=null):*
		function removeLocalData(key:Object):*
		function flushLocal():String
		function clearLocal():void
	}
}