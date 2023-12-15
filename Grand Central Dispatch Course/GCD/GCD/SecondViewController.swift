//
//  SecondViewController.swift
//  GCD
//
//  Created by mac on 15.12.2023.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }

        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchImage()
    }

    fileprivate func fetchImage() {
        imageURL = URL(string: "https://wallpapers.com/images/featured-full/beautiful-3vau5vtfa3qn7k8v.jpg")
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false

        DispatchQueue.global(qos: .utility).async {
            guard let url = self.imageURL, let data = try? Data(contentsOf: url) else { return }

            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
