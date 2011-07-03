package org.foomo.flash.logging
{
	public interface ILoggingTarget
	{
		function format(category:String, message:String, level:int):String;
		function output(message:String, level:int):void;
	}
}