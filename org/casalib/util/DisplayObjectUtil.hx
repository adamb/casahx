﻿/*
	#if flash
			#if flash
			#end
			
			if (Std.is( parent, Loader) || !(Std.is( parent, DisplayObjectContainer)))
				var child = container.getChildAt(0);
				container.removeChildAt(0);
				DisplayObjectUtil._checkChild(child, destroyChildren, recursive);
			}
		#if flash
		#end