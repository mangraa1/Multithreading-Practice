import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


let queue = DispatchQueue(label: "GCD.heorhii", attributes: .concurrent)

//MARK: - First group
let firstGroup = DispatchGroup()

queue.async(group: firstGroup) {

    for i in 0...10 {
        if i == 10 {
            print("first group: ", i)
        }
    }
}

firstGroup.notify(queue: .main) {
    print("firstGroup notify")
}


//MARK: - Second Group
let secondGroup = DispatchGroup()

secondGroup.enter()
queue.async(group: secondGroup) {

    for i in 0...20 {
        if i == 20 {
            sleep(1)
            print("second group: ", i)
            secondGroup.leave()
        }
    }
}

let result = secondGroup.wait(timeout: .now() + 3)
print("Result: ", result)

secondGroup.notify(queue: .main) {
    print("secondGroup notify")
}

print("This line will be displayed before the notify")
