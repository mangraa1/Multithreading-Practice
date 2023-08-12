//
//  ViewController.swift
//  asyncAfter &  ConcurrentPerform & initiallyInactive
//
//  Created by mac on 12.08.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        afterBlock(seconds: 2, queue: .main) {
            self.showAlert()
            print(Thread.current)
        }
    }

    private func showAlert() {
        let alert = UIAlertController(title: nil, message: "Hello", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)

        alert.addAction(okAction)
        present(alert, animated: true)
    }

    // An action that is performed after some time
    private func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), completion: @escaping () -> ()) {

        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            completion()
        }
    }
}

