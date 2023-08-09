import UIKit

//MARK: Reqursive mutex

class RecursiveMutexTest {
    private var mutex = pthread_mutex_t()
    private var attribute = pthread_mutexattr_t()

    init() {
        pthread_mutexattr_init(&attribute) // Init attribute
        pthread_mutexattr_settype(&attribute, PTHREAD_MUTEX_RECURSIVE) // Recursion attribute assignment
        pthread_mutex_init(&mutex, &attribute) // Init mutex
    }

    func firstTask() {
        pthread_mutex_lock(&mutex) // Thread acquired lock
        secondTask()
        do {
            pthread_mutex_unlock(&mutex) // Flow unblocking
        }
    }

    private func secondTask() {
        pthread_mutex_lock(&mutex) // Thread acquired lock
        print("Finish")
        do {
            pthread_mutex_unlock(&mutex) // Flow unblocking
        }
    }
}

let recursive = RecursiveMutexTest()
recursive.firstTask()

//MARK: - NSRecursiveLock

let recursiveLock = NSRecursiveLock()

class RecursiveThread: Thread {

    override func main() {
        recursiveLock.lock()
        print("Thread acquired lock (main)")

        callMe()

        do {
            recursiveLock.unlock()
        }
        print("Exit main")
    }

    private func callMe() {
        recursiveLock.lock()
        print("Thread acquired lock (callMe)")

        do {
            recursiveLock.unlock()
        }
        print("Exit callMe")
    }
}

let thread = RecursiveThread()
thread.start()
