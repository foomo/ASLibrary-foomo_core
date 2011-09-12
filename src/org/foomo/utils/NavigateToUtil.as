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
package org.foomo.utils
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class NavigateToUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		public static function mailto(to:Array, subject:String=null, body:String=null, cc:Array=null, bcc:Array=null):void
		{
			var url:String = 'mailto:' + to.join(',');
			var parms:Array = [];
			if (cc) parms.push(cc.join(','));
			if (bcc) parms.push(bcc.join(','));
			if (subject) parms.push('subject=' + subject);
			if (body) parms.push('body=' + StringUtil.replaceAll(body, '\n', '%0A'));
			if (parms.length > 0) url += '?' + parms.join('&');
			NavigateToUtil.url(url);
		}

		public static function url(url:String, window:String='_blank'):void
		{
			navigateToURL(new URLRequest(url), window);
		}
	}
}