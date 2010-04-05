﻿/*
	import org.casalib.core.UInt;
			while (this._sequence.length > 0)
				this._sequence.pop();
		
		function resetInterval():Void {
			#if cpp 
			if (_interval.running) _interval.stop();
			#elseif js
			this._interval.removeEventListeners();
			this._interval = Interval.setTimeout(this._delayComplete, 1);
			#else
			this._interval.reset();
			#end
		}

private class Task {
	public var closure:Dynamic;
	public var delay:Float;
	public var scope:IEventDispatcher;
	public var completeEventName:String;
	
	
	public function new(closure:Dynamic, delay:Float, scope:IEventDispatcher, completeEventName:String) {
		this.closure           = closure;
		this.delay             = delay;
		this.scope             = scope;
		this.completeEventName = completeEventName;
	}
}