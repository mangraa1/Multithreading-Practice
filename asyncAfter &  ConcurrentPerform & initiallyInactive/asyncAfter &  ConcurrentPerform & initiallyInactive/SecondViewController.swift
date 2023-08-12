//
//  SecondViewController.swift
//  asyncAfter &  ConcurrentPerform & initiallyInactive
//
//  Created by mac on 12.08.2023.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        myConcurrentPerform()
        myInactiveQueue()
    }

    //MARK: - private

    private func myConcurrentPerform() {
        let queue = DispatchQueue.global(qos: .utility)

        queue.async {
            DispatchQueue.concurrentPerform(iterations: 100_000) { _ in
            }

            queue.async {
                print("Concurrent tasks are finished!")
            }
        }
    }

    private func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "myQueue", attributes: [.concurrent, .initiallyInactive])

        // This code is executed second
        inactiveQueue.asyncAfter(deadline: .now() + 8) {
            inactiveQueue.async {
                DispatchQueue.main.async {
                    self.myLabel.text = "Done!"
                }
            }
        }

        // This code is executed first
        print("Not yet started...")
        inactiveQueue.activate()  // Activates a previously unactivated queue
        print("Activate")
        inactiveQueue.suspend() // Pauses the queue
        print("Pause")
        inactiveQueue.resume() // Resumes the queue
    }
}
