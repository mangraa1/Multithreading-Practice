import UIKit
import Foundation

//MARK: pthread mutex

class SaveThread {
    private var mutex = pthread_mutex_t()

    init() {
        pthread_mutex_init(&mutex, nil)
    }

    func someMethod(completion: () -> ()) {
        pthread_mutex_lock(&mutex)

        completion()

        do { // Unlock even in case of error
            pthread_mutex_unlock(&mutex)
        }
    }
}

var array = [String]()
let saveThread = SaveThread()

saveThread.someMethod {
    print("test1")
    array.append("1 thread")
}
array.append("2 thread")

// MARK: - NSLock

class SaveThread2 {
    private let lockMutex = NSLock()

    func someMethod(completion: () -> ()) {
        lockMutex.lock()

        completion()

        do {
            lockMutex.unlock()
        }
    }
}

var array2 = [String]()
let saveThread2 = SaveThread2()

saveThread2.someMethod {
    print("test2")
    array2.append("1 thread")
}
array2.append("2 thread")
