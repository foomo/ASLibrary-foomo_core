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
	import flash.errors.EOFError;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * Loads a SWF file as version 9 format forcibly even if version is under 9.
	 *
	 * Usage:
	 * <pre>
	 * var loader:Loader = Loader(addChild(new Loader()));
	 * var fLoader:ForcibleLoader = new ForcibleLoader(loader);
	 * fLoader.load(new URLRequest('swf7.swf'));
	 * </pre>
	 *
	 */
	/**
	 * @link    http://www.foomo.org
	 * @license http://www.gnu.org/licenses/lgpl.txt
	 * @author  franklin <franklin@weareinteractive.com>
	 */
	public class SwfUtil
	{
		//-----------------------------------------------------------------------------------------
		// ~ Public methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @see 	http://www.be-interactive.org/?itemid=250
		 * @see 	http://fladdict.net/blog/2007/05/avm2avm1swf.html
		 * @author 	yossy:beinteractive
		 */
		public static function update(binary:ByteArray):ByteArray
		{
			binary.endian = Endian.LITTLE_ENDIAN;
			if (ByteArrayUtil.isCompressed(binary)) ByteArrayUtil.uncompress(binary);

			var version:uint = uint(binary[3]);

			if (version < 9) {
				SwfUtil.updateVersion(binary, 9);
			}

			if (version > 7) {
				SwfUtil.flagSWF9Bit(binary);
			}
			else {
				SwfUtil.insertFileAttributesTag(binary);
			}
			return binary
		}

		//-----------------------------------------------------------------------------------------
		// ~ Private static methods
		//-----------------------------------------------------------------------------------------

		/**
		 * @see 	http://www.be-interactive.org/?itemid=250
		 * @see 	http://fladdict.net/blog/2007/05/avm2avm1swf.html
		 * @author 	yossy:beinteractive
		 */
		private static function updateVersion(bytes:ByteArray, version:uint):void
		{
			bytes[3] = version;
		}

		/**
		 * @see 	http://www.be-interactive.org/?itemid=250
		 * @see 	http://fladdict.net/blog/2007/05/avm2avm1swf.html
		 * @author 	yossy:beinteractive
		 */
		private static function flagSWF9Bit(bytes:ByteArray):void
		{
			var pos:int = SwfUtil.findFileAttributesPosition(SwfUtil.getBodyPosition(bytes), bytes);
			if (pos != -1) {
				bytes[pos + 2] |= 0x08;
			} else {
				SwfUtil.insertFileAttributesTag(bytes);
			}
		}

		/**
		 * @see 	http://www.be-interactive.org/?itemid=250
		 * @see 	http://fladdict.net/blog/2007/05/avm2avm1swf.html
		 * @author 	yossy:beinteractive
		 */
		private static function findFileAttributesPosition(offset:uint, bytes:ByteArray):int
		{
			bytes.position = offset;

			try {
				for (;;) {
					var byte:uint = bytes.readShort();
					var tag:uint = byte >>> 6;
					if (tag == 69) {
						return bytes.position - 2;
					}
					var length:uint = byte & 0x3f;
					if (length == 0x3f) {
						length = bytes.readInt();
					}
					bytes.position += length;
				}
			} catch (e:EOFError) {
			}

			return -1;
		}

		/**
		 * @see 	http://www.be-interactive.org/?itemid=250
		 * @see 	http://fladdict.net/blog/2007/05/avm2avm1swf.html
		 * @author 	yossy:beinteractive
		 */
		private static function getBodyPosition(bytes:ByteArray):uint
		{
			var result:uint = 0;

			result += 3; // FWS/CWS
			result += 1; // version(byte)
			result += 4; // length(32bit-uint)

			var rectNBits:uint = bytes[result] >>> 3;
			result += (5 + rectNBits * 4) / 8; // stage(rect)

			result += 2;

			result += 1; // frameRate(byte)
			result += 2; // totalFrames(16bit-uint)

			return result;
		}

		/**
		 * @see 	http://www.be-interactive.org/?itemid=250
		 * @see 	http://fladdict.net/blog/2007/05/avm2avm1swf.html
		 * @author 	yossy:beinteractive
		 */
		private static function insertFileAttributesTag(bytes:ByteArray):void
		{
			var pos:uint = getBodyPosition(bytes);
			var afterBytes:ByteArray = new ByteArray();
			afterBytes.writeBytes(bytes, pos);
			bytes.length = pos;
			bytes.position = pos;
			bytes.writeByte(0x44);
			bytes.writeByte(0x11);
			bytes.writeByte(0x08);
			bytes.writeByte(0x00);
			bytes.writeByte(0x00);
			bytes.writeByte(0x00);
			bytes.writeBytes(afterBytes);
			afterBytes.length = 0;
		}
	}
}