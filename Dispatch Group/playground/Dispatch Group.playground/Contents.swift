import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//MARK: - Test 1

class DispatchGroupSerial {
    private let queueSerial = DispatchQueue(label: "My serial queue")
    private let firstGroup = DispatchGroup()

    public func loadInfo() {
        queueSerial.async(group: firstGroup) {
            sleep(2)
            print("Task 1")
        }

        queueSerial.async(group: firstGroup) {
            sleep(2)
            print("Task 2")
        }

        firstGroup.notify(queue: .main) {
            print("The firstGroup finished")
        }
    }
}

//MARK: - Test 2

class DispatchGroupCuncurrent {
    private let queueConcurrent = DispatchQueue(label: "My concurrent queue", attributes: .concurrent)
    private let secondGroup = DispatchGroup()

    public func loadInfo() {

        secondGroup.enter()
        queueConcurrent.async(group: secondGroup) {
            sleep(2)
            print("Task 1")
            self.secondGroup.leave()
        }

        secondGroup.enter()
        queueConcurrent.async(group: secondGroup) {
            sleep(2)
            print("Task 2")
            self.secondGroup.leave()
        }

        secondGroup.wait()
        print("Finish all")

        secondGroup.notify(queue: .main) {
            print("The secondGroup finished")
        }
    }
}


//MARK: - Task with uploading photo group from the Internet

class CustomView: UIView {
    public var imageViews = [UIImageView]()

    public override init(frame: CGRect) {
        super.init(frame: frame)

        imageViews.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200)))
        imageViews.append(UIImageView(frame: CGRect(x: 0, y: 200, width: 200, height: 200)))
        imageViews.append(UIImageView(frame: CGRect(x: 200, y: 0, width: 200, height: 200)))
        imageViews.append(UIImageView(frame: CGRect(x: 200, y: 200, width: 200, height: 200)))

        for i in 0...imageViews.count - 1 {
            imageViews[i].contentMode = .scaleAspectFit
            self.addSubview(imageViews[i])
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Setup Interface
var myView = CustomView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
myView.backgroundColor = .systemBlue

PlaygroundPage.current.liveView = myView

// Images to upload
let imageURLs = ["https://images.pexels.com/photos/220769/pexels-photo-220769.jpeg?auto=compress&cs=tinysrgb&w=1200", "https://lp-cms-production.imgix.net/2021-03/shutterstock_304631102.jpg?auto=format&w=1440&h=810&fit=crop&q=75", "https://img.freepik.com/free-photo/central-park-manhattan-new-york-huge-beautiful-park-surrounded-by-skyscraper-with-pond_181624-50335.jpg?w=2000", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfFY4dw-1j8V8s-IQq8oz9kRNAxs36c6cxTw&usqp=CAU"]
var images = [UIImage]()

// Downloading images from the internet
func asyncLoadImage(imageURL: URL, runQueue: DispatchQueue, completionQueue: DispatchQueue, completion: @escaping (UIImage?, Error?) -> ()) {
    runQueue.async {
        do {
            let data = try Data(contentsOf: imageURL)
            completionQueue.async { completion(UIImage(data: data), nil) }
        } catch let error {
            completion(nil, error)
        }
    }
}

// Form a group of asynchronous operations
func asyncGroup() {
    let myGroup = DispatchGroup()

    for i in 0...imageURLs.count - 1 {
        myGroup.enter()
        asyncLoadImage(imageURL: URL(string: imageURLs[i])!, runQueue: .global(), completionQueue: .main) { result, error in
            guard let image = result else { return }
            images.append(image)
            myGroup.leave()
        }
    }

    myGroup.notify(queue: .main) {
        for i in 0...images.count - 1 {
            myView.imageViews[i].image = images[i]
        }
    }
}
asyncGroup()
