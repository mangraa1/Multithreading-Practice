import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


let workItem = DispatchWorkItem(qos: .utility, flags: .detached) {
    print("Perform workItem")
}

//workItem.perform()

let queue = DispatchQueue(label: "GCD.heorhii", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem, target: DispatchQueue.global(qos: .userInitiated))

queue.asyncAfter(deadline: .now() + 1, execute: workItem)

workItem.notify(queue: .main) {
    print("workItem notify")
}

workItem.isCancelled // false
workItem.cancel()
workItem.isCancelled // true

workItem.wait()

