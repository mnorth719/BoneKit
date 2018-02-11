/*
 Observable
 
 Created by Matt  North on 8/6/17.
 Copyright © 2017 Matt North. All rights reserved.
 
 LICENSE
 
 Copyright (c) 2017 mnorth719 <matt.north93@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 
 */
import Foundation

public class Observable<T> {
    
    public enum EventType {
        case valueDidChange
        case valueWillChange
    }
    
    public typealias eventClosure = (T) -> Void
    private var eventStorage = [EventType: eventClosure]()
    
    public init(_ value: T) {
        self.value = value
    }
    
    public var value: T {
        didSet {
            eventStorage[.valueDidChange]?(value)
        }
        willSet(newValue) {
            eventStorage[.valueWillChange]?(newValue)
        }
    }
    
    public func onEvent(_ event: EventType, closure: @escaping eventClosure) {
        eventStorage[event] = closure
    }
    
    public func removeObservers() {
        eventStorage = [EventType: eventClosure]()
    }
    
    public func removeObserver(_ event: EventType) {
        eventStorage[event] = nil
    }
}

/**
 Convenience operator for directly setting an observable value.
 
 Ex:
 
 someObservableInt << 10
 print(someObservableInt.value)
 // Output: 10
 
 */
public func <<<T>(left: Observable<T>, right: T) {
    left.value = right
}

