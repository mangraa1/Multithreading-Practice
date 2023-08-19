import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//MARK: - Test 1

let operationQueue = OperationQueue()

class OperationCancelTest: Operation {
    override func main() {
        if isCancelled {
            print(isCancelled)
            return
        }
        print("test 1")
        sleep(1)

        if isCancelled {
            print(isCancelled)
            return
        }
        print("test 2")
    }
}

func cancelOperationMethod() {
    let cancelOperation = OperationCancelTest()
    operationQueue.addOperation(cancelOperation)
    cancelOperation.cancel()
}
//cancelOperationMethod()


//MARK: - Test 2

class FirstWaitOperationTest {
    private let myOperationQueue = OperationQueue()

    public func test() {
        myOperationQueue.addOperation {
            sleep(2)
            print("test1")
        }
        myOperationQueue.waitUntilAllOperationsAreFinished()

        myOperationQueue.addOperation {
            sleep(1)
            print("test2")
        }
        myOperationQueue.waitUntilAllOperationsAreFinished()

        myOperationQueue.addOperation {
            print("test3")
        }
    }
}

let firstWaitTest = FirstWaitOperationTest()
//waitTest.test()


//MARK: Test 3

class SecondWaitOperationTest: Operation {
    private let myOperationQueue = OperationQueue()

    public func test() {
        let operation1 = BlockOperation {
            sleep(1)
            print("test1")
        }

        let operation2 = BlockOperation {
            sleep(2)
            print("test2")
        }

        myOperationQueue.addOperations([operation1, operation2], waitUntilFinished: true)
    }
}

let secondWaitTest = SecondWaitOperationTest()
//secondWaitTest.test()


//MARK: - Test 4

class CompletionBlockTest {
    private let myOperationQueue = OperationQueue()

    public func test() {
        let operation1 = BlockOperation {
            sleep(3)
            print("Operation block")
        }

        operation1.completionBlock = {
            print("Completion block")
        }

        myOperationQueue.addOperation(operation1)
    }
}

let completionTest = CompletionBlockTest()
//completionTest.test()
