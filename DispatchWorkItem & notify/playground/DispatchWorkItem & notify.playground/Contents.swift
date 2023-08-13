import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//MARK: Test

class DispatchWorkItemTest {
    private let myQueue = DispatchQueue(label: "DispatchWorkItemTest", attributes: .concurrent)

    public func createWorkItem() {

        let workItem = DispatchWorkItem { // Block of code to be executed
            print(Thread.current)
            print("My tasks")
        }

        workItem.notify(queue: .main) { // Execute block of code after completion
            print(Thread.current)
            print("Tasks completed")
        }

        myQueue.async(execute: workItem) // Execute the block of code in the given queue

        workItem.cancel() // Cancel block execution
    }
}


//MARK: - Task with uploading photos from the Internet in different ways

// Setup Interface
let view = UIView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))

myImageView.backgroundColor = .systemBlue
myImageView.contentMode = .scaleAspectFit
view.addSubview(myImageView)

PlaygroundPage.current.liveView = view

let imageURL = URL(string: "https://images.pexels.com/photos/220769/pexels-photo-220769.jpeg?auto=compress&cs=tinysrgb&w=1200")!

//# Classic
func fetchImage1() {
    let queue = DispatchQueue.global(qos: .utility)

    queue.async {
        if let data = try? Data(contentsOf: imageURL) {
            DispatchQueue.main.async {
                myImageView.image = UIImage(data: data)
            }
        }
    }
}

//# Dispatch work item
func fetchImage2() {
    var data: Data?
    let queue = DispatchQueue.global(qos: .utility)

    let workItem = DispatchWorkItem(qos: .utility) { // Convert data
        data = try? Data(contentsOf: imageURL)
    }

    queue.async(execute: workItem) // Execute the block of code in the given queue

    workItem.notify(queue: .main) { // After completion, insert our image into imageView
        if let imageData = data {
            myImageView.image = UIImage(data: imageData)
        }
    }
}

//# URLSession
func fetchImage3() {

    let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
        if let imageData = data {
            DispatchQueue.main.async {
                myImageView.image = UIImage(data: imageData)
            }
        }
    }

    task.resume()
}
fetchImage3()
