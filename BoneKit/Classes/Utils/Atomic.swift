/*
 Atomic
 Created by Matt North on 8/6/17.
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

fileprivate class PThreadMutex {
    fileprivate typealias RawMutex = pthread_mutex_t
    private var unsafeMutex = pthread_mutex_t()
    
    fileprivate init() {
        var attr = pthread_mutexattr_t()
        guard pthread_mutexattr_init(&attr) == 0 else {
            preconditionFailure()
        }
        
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_NORMAL)
        
        guard pthread_mutex_init(&unsafeMutex, &attr) == 0 else {
            preconditionFailure()
        }
    }
    
    deinit {
        pthread_mutex_destroy(&unsafeMutex)
    }
    
    func sync<T>(execute: () -> T) -> T {
        pthread_mutex_lock(&unsafeMutex)
        defer { pthread_mutex_unlock(&unsafeMutex) }
        return execute()
    }
}

/**
 This Generic Type provides a wrapper that will mutex around its internal value.
 Similarly to ObjC's Atomic properties, using this class will provide
 atomic access to that property. This does come at a slight cost, as creating
 a mutex has a resource cost.
 
 
 ## Declaration:
 
 var safeInt = Atomic`<`Int`>`(10)
 
 ## Usage:
 safeInt.value = 55
 
 
 `-` or `-`
 
 
 Using the custom operators << and >>
 
 safeInt << 55
 55 >> safeInt
 
 */
public class Atomic<T> {
    init(_ value: T) {
        internalValue = value
    }
    
    private var mutex = PThreadMutex()
    private var internalValue: T
    var value: T {
        get {
            return mutex.sync {
                return internalValue
            }
        }
        set (newValue) {
            mutex.sync {
                internalValue = newValue
            }
        }
    }
}

/**
 Convenience operator for directly setting an atomic properties value.
 
 Ex:
 
 someAtomicInt << 10
 print(someAtomicInt.value)
 // Output: 10
 
 */
public func <<<T>(left: Atomic<T>, right: T) {
    left.value = right
}




