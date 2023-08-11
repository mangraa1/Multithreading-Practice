//
//  SecondViewController.swift
//  GCD
//
//  Created by mac on 11.08.2023.
//

import UIKit

class SecondViewController: UIViewController {

    //MARK: Variables

    var imageView = UIImageView()

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Second VC"
        view.backgroundColor = UIColor(red: 211/247, green: 211/247, blue: 211/247, alpha: 1)

        initImageView()
        loadPhoto()
    }

    //MARK: - UI

    private func initImageView() {
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        view.addSubview(imageView)
    }

    private func loadPhoto() {
        let imageURL = URL(string: "https://images.pexels.com/photos/220769/pexels-photo-220769.jpeg?auto=compress&cs=tinysrgb&w=1200")!

        let queue = DispatchQueue.global(qos: .utility) // Creating a high priority global queue

        queue.async { //Execute actions on another thread

            if let data = try? Data(contentsOf: imageURL) {

                // All UI must be executed in the main thread
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
}
