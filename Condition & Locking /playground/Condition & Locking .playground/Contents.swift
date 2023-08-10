import UIKit

// NSCondition, NSLocking, pthread_cond_t

//MARK: - POSIX Threads Condition

var condition = pthread_cond_t()
var mutex = pthread_mutex_t()

var booleanPredicate = false

class ConditionMutexPrinter: Thread {

    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }

    override func main() {
        printMethod()
    }

    private func printMethod() {
        pthread_mutex_lock(&mutex)

        while !booleanPredicate {
            pthread_cond_wait(&condition, &mutex) // Waiting for a signal
        }
        booleanPredicate = false // For reuse

        print("print something")

        do {
            pthread_mutex_unlock(&mutex)
        }
    }
}

class ConditionMutexWriter: Thread {

    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }

    override func main() {
        writerMethod()
    }

    private func writerMethod() {
        pthread_mutex_lock(&mutex)

        // Do something

        booleanPredicate = true
        pthread_cond_signal(&condition) // Sending a signal to condition

        do {
            pthread_mutex_unlock(&mutex)
        }
    }
}

let conditionMutexPrinter = ConditionMutexPrinter()
let conditionMutexWriter = ConditionMutexWriter()

conditionMutexPrinter.start()
conditionMutexWriter.start()


//MARK: - NSCondition

let nsCondition = NSCondition()
var boolPredicate = false

class PrinterThread: Thread {

    override func main() {
        nsCondition.lock()

        while !boolPredicate {
            nsCondition.wait() // Waiting for a signal
        }
        boolPredicate = false // For reuse

        print("print something")

        nsCondition.unlock()
    }
}

class WriterThread: Thread {

    override func main() {
        nsCondition.lock()

        // Do something

        boolPredicate = true
        nsCondition.signal() // Sending a signal to condition

        nsCondition.unlock()
    }
}

let printerThread = PrinterThread()
let writerThread = WriterThread()

printerThread.start()
writerThread.start()
