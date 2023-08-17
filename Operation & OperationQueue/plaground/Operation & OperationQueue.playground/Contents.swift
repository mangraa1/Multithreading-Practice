import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//MARK: - Test 1

print(Thread.current)

let firstOperation = {
    print("firstOperation ------ \(Thread.current)")
}

let queue1 = OperationQueue()
queue1.addOperation(firstOperation)


//MARK: - Test 2

var result: String?
let concatOperation = BlockOperation {
    result = "My " + "concatenation Operation"
    print(Thread.current)
}

let queue2 = OperationQueue()
queue2.addOperation(concatOperation)

sleep(2)
print("Result of concatenation: \(result ?? "Not defined")")


//MARK: - Test 3

let queue3 = OperationQueue()
queue3.addOperation {
    print("secondOperation ------ \(Thread.current)")
}


//MARK: - Test 4

class MyOperation: Operation {
    override func main() {
        print("Inside myOperation ------ \(Thread.current)")
    }
}

let myOperation = MyOperation()

let queue4 = OperationQueue()
queue4.addOperation(myOperation)
