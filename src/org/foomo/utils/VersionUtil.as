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
	import org.foomo.managers.LogManager;

	/**
	 * @link www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author franklin <franklin@weareinteractive.com>
	 */
	public class VersionUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public static methods
		//-----------------------------------------------------------------------------------------
		
		/**
		 * http://phpjs.org/functions/version_compare/
		 * http://kevin.vanzonneveld.net
  		 * original by: Philippe Jausions (http://pear.php.net/user/jausions)
 		 * original by: Aidan Lister (http://aidanlister.com/)
		 * reimplemented by: Kankrelune (http://www.webfaktory.info/)
		 * 
		 * example 1: version_compare('8.2.5rc', '8.2.5a');
		 * returns 1: 1
		 * example 2: version_compare('8.2.50', '8.2.52', '<');
		 * returns 2: true
		 * example 3: version_compare('5.3.0-dev', '5.3.0');
		 * returns 3: -1
		 * example 4: version_compare('4.1.0.52','4.01.0.51');
		 * returns 4: 1
		 * 
		 * @param v1
		 * @param v2
		 * @param operator
		 * @return 
		 */
		public static function compare(v1:String, v2:String, operator:String=">"):Boolean
		{
			var i:int = 0;
			var x:int = 0;
			var compare:int = 0;
			var v1e:Array = prepVersion(v1);
			var v2e:Array = prepVersion(v2);
			x = Math.max(v1e.length, v2e.length);
			for (i = 0; i < x; i++) {
				if (v1e[i] == v2e[i]) {
					continue;
				}
				v1e[i] = numVersion(v1e[i]);
				v2e[i] = numVersion(v2e[i]);
				if (v1e[i] < v2e[i]) {
					compare = -1;
					break;
				} else if (v1e[i] > v2e[i]) {
					compare = 1;
					break;
				}
			}
			
			// Important: operator is CASE-SENSITIVE.
			// "No operator" seems to be treated as "<."
			// Any other values seem to make the function return null.
			switch (operator) {
				case '>':
				case 'gt':
					return (compare > 0);
				case '>=':
				case 'ge':
					return (compare >= 0);
				case '<=':
				case 'le':
					return (compare <= 0);
				case '==':
				case '=':
				case 'eq':
					return (compare === 0);
				case '<>':
				case '!=':
				case 'ne':
					return (compare !== 0);
				case '':
				case '<':
				case 'lt':
					return (compare < 0);
				default:
					throw new Error('Unknown compare operator: ' + operator);
			}
		}
		
		//-----------------------------------------------------------------------------------------
		// ~ Private static methods
		//-----------------------------------------------------------------------------------------
		
		
		/**
		 * This converts a version component to a number.
		 * Empty component becomes 0.
		 * Non-numerical component becomes a negative number.
		 * Numerical component becomes itself as an integer.
		 * 
		 * @param v
		 * @return 
		 */
		private static function numVersion(v:String):int 
		{
			// vm maps textual PHP versions to negatives so they're less than 0.
			// PHP currently defines these as CASE-SENSITIVE. It is important to
			// leave these as negatives so that they can come before numerical versions
			// and as if no letters were there to begin with.
			// (1alpha is < 1 and < 1.1 but > 1dev1)
			// If a non-numerical value can't be mapped to this table, it receives
			// -7 as its value.
			var vm:Object = {
				'dev': -6,
				'alpha': -5,
				'a': -5,
				'beta': -4,
				'b': -4,
				'RC': -3,
				'rc': -3,
				'#': -2,
				'p': -1,
				'pl': -1
			}
			return !v ? 0 : (isNaN(Number(v)) ? vm[v] || -7 : parseInt(v, 10));
		}
		
		/**
		 * This function will be called to prepare each version argument.
		 * It replaces every _, -, and + with a dot.
		 * It surrounds any nonsequence of numbers/dots with dots.
		 * It replaces sequences of dots with a single dot.
		 *    version_compare('4..0', '4.0') == 0
		 * Important: A string of 0 length needs to be converted into a value
		 * even less than an unexisting value in vm (-7), hence [-8].
		 * It's also important to not strip spaces because of this.
		 *   version_compare('', ' ') == 1
		 * 
		 * @param v
		 * @return 
		 */
		private static function prepVersion(v:String):Array 
		{
			v = ('' + v).replace(/[_\-+]/g, '.');
			v = v.replace(/([^.\d]+)/g, '.$1.').replace(/\.{2,}/g, '.');
			return (!v.length ? [-8] : v.split('.'));
		}
	}
}