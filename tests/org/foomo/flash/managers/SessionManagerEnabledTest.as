package org.foomo.flash.managers
{
	import flash.net.SharedObjectFlushStatus;

	import flexunit.framework.Assert;

	public class SessionManagerEnabledTest
	{
		//-----------------------------------------------------------------------------------------
		// ~ Constants
		//-----------------------------------------------------------------------------------------

		private static const KEY:String = 'org.foomo.flash.managers.SharedOjectManager';
		private static const VALUE:String = 'foobar';

		//-----------------------------------------------------------------------------------------
		// ~ Variables
		//-----------------------------------------------------------------------------------------

		private static var _clientId:String;
		private static var _sessionId:String;

		//-----------------------------------------------------------------------------------------
		// ~ Initialization
		//-----------------------------------------------------------------------------------------

		[Before]
		public function setUp():void
		{
			SessionManager.clearLocal();
		}

		[After]
		public function tearDown():void
		{
		}

		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}

		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}

		//-----------------------------------------------------------------------------------------
		// ~ Test methods
		//-----------------------------------------------------------------------------------------

		[Test]
		public function testGet_localIsAvailable():void
		{
			Assert.assertTrue(SessionManager.localIsAvailable);
		}

		[Test(order=1)]
		public function testGet_sessionId():void
		{
			Assert.assertEquals(SessionManager.sessionId.length, 36);
			_sessionId = SessionManager.sessionId;
		}

		[Test(order=2)]
		public function testGet_sessionIdAgain():void
		{
			Assert.assertTrue(_sessionId == SessionManager.sessionId);
		}

		[Test(order=3)]
		public function testGet_clientId():void
		{
			Assert.assertEquals(SessionManager.clientId.length, 36);
			Assert.assertTrue(SessionManager.clientId != SessionManager.sessionId);
			_clientId = SessionManager.clientId;
		}

		[Test(order=4)]
		public function testGet_clientIdAgain():void
		{
			Assert.assertTrue(_clientId == SessionManager.clientId);
		}

		[Test]
		public function testFlushLocal():void
		{
			Assert.assertEquals(SharedObjectFlushStatus.FLUSHED, SessionManager.flushLocal());
		}

		[Test]
		public function testSetLocalData():void
		{
			Assert.assertEquals(SessionManager.setLocalData(KEY, VALUE), VALUE);
		}

		[Test]
		public function testGetLocalData():void
		{
			Assert.assertNull(SessionManager.getLocalData(KEY));
			Assert.assertEquals(VALUE, SessionManager.getLocalData(KEY, VALUE));
		}

		[Test]
		public function testRemoveLocalData():void
		{
			SessionManager.setLocalData(KEY, VALUE);
			var ret:String = SessionManager.removeLocalData(KEY);
			Assert.assertEquals(VALUE, ret);
			Assert.assertNull(SessionManager.getLocalData(KEY))
		}

		[Test]
		public function testClearLocal():void
		{
			SessionManager.setLocalData(KEY, VALUE);
			SessionManager.clearLocal();
			Assert.assertNull(SessionManager.getLocalData(KEY))
		}
	}
}