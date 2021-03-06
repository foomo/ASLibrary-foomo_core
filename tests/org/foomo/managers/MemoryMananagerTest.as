package org.foomo.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	import flexunit.framework.Assert;

	import org.foomo.memory.DisplayObjectContainerUnloader;
	import org.foomo.memory.DisplayObjectUnloader;
	import org.foomo.memory.MovieClipUnloader;
	import org.foomo.memory.Unloader;

	public class MemoryMananagerTest
	{
		//-----------------------------------------------------------------------------------------
		// ~ Initialization
		//-----------------------------------------------------------------------------------------

		[Before]
		public function setUp():void
		{
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
		public function testGc():void
		{
			Assert.assertNull(MemoryMananager.gc());
		}
		
		[Test]
		public function testRemoveUnloader():void
		{
			var parent:MovieClip = new MovieClip;
			var child:MovieClip = new MovieClip;
			parent.addChild(child);
			
			MemoryMananager.removeUnloader(DisplayObjectContainer);
			
			MemoryMananager.unload(parent);
			Assert.assertEquals(parent.getChildAt(0), child);
		}

		[Test]
		public function testAddUnloader():void
		{
			var parent:MovieClip = new MovieClip;
			var child:MovieClip = new MovieClip;
			parent.addChild(child);
			
			MemoryMananager.removeUnloader(DisplayObjectContainer);
			
			MemoryMananager.unload(parent);
			Assert.assertEquals(parent.getChildAt(0), child);
			MemoryMananager.addUnloader(DisplayObjectContainer, new DisplayObjectContainerUnloader);

			MemoryMananager.unload(parent);
			Assert.assertEquals(0, parent.numChildren);
		}

		[Test]
		public function testUnload():void
		{
			Unloader.addAll();

			var parent:MovieClip = new MovieClip;
			var child:MovieClip = new MovieClip;
			parent.addChild(child);

			MemoryMananager.unload(parent);
			Assert.assertEquals(parent.numChildren, 0);
		}
	}
}