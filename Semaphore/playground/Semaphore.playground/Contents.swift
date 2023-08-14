import UIKit

let queue = DispatchQueue(label: "My Queue", attributes: .concurrent)

//MARK: - Test 1
let semaphore1 = DispatchSemaphore(value: 0)

queue.async {
    semaphore1.wait() // -1
    sleep(2)
    print("Task 1")
    semaphore1.signal() // +1
}

queue.async {
    semaphore1.wait() // -1
    sleep(2)
    print("Task 2")
    semaphore1.signal() // +1
}

queue.async {
    semaphore1.wait() // -1
    sleep(2)
    print("Task 3")
    semaphore1.signal() // +1
}

//MARK: - Test 2

let semaphore2 = DispatchSemaphore(value: 0)

DispatchQueue.concurrentPerform(iterations: 10) { (id: Int) in
    semaphore2.wait(timeout: DispatchTime.distantFuture)

    sleep(2)
    print("Block \(id) --------- \(Thread.current)")

    semaphore2.signal()
}


//MARK: - Test 3

class SemaphorTest {
    private let semaphore = DispatchSemaphore(value: 2)
    private var myArray = [Int]()

    private func passToArray(_ id: Int) {
        semaphore.wait() // +1

        myArray.append(id)

        Thread.sleep(forTimeInterval: 2)
        semaphore.signal() // -1
    }

    public func startAllThread() {
        DispatchQueue.global().async {
            self.passToArray(10023)
        }

        DispatchQueue.global().async {
            self.passToArray(1001)
        }

        DispatchQueue.global().async {
            self.passToArray(323)
        }

        DispatchQueue.global().async {
            self.passToArray(353)
        }
    }
}
