import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


let queue = DispatchQueue(label: "GCD.heorhii.source", attributes: .concurrent)

let timer = DispatchSource.makeTimerSource(queue: queue)

timer.schedule(deadline: .now(), repeating: .seconds(2), leeway: .milliseconds(300))
timer.setEventHandler {
    print("Hello, World!")
}

timer.setCancelHandler {
    print("timer is cancelled")
}

timer.resume()
