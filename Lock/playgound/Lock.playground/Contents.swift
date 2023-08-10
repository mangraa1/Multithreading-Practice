import UIKit

//MARK: - Read Write Lock

class ReadWriteLock {
    private var lock = pthread_rwlock_t()
    private var attribute = pthread_rwlockattr_t()

    private var resource: Int32 = 0

    init() {
        pthread_rwlock_init(&lock, &attribute)
    }

    public var testProperty: Int32 {
        get {
            pthread_rwlock_rdlock(&lock) // Lock the resource for reading

            let temp = resource // Create a temporary variable

            pthread_rwlock_unlock(&lock) // Free the resource

            return temp
        }

        set {
            pthread_rwlock_wrlock(&lock) // Lock the resource for writing

            resource = newValue

            pthread_rwlock_unlock(&lock) // Free the resource
        }
    }
}


//MARK: - Unfair Lock

class UnfairLock {
    private var lock = os_unfair_lock_s()

    private var myArray = [Int]()

    public func doSomething() {
        os_unfair_lock_lock(&lock)
        [1,5,7,3,2,5,45].forEach {myArray.append($0)}
        os_unfair_lock_unlock(&lock)
    }
}


//MARK: - Synchronized

class SynchronizedObjc {
    private var lock = NSObject()

    private var myArray = [Int]()

    public func doSomething() {
        objc_sync_enter(lock)
        myArray.append(23)
        objc_sync_exit(lock)
    }
}
