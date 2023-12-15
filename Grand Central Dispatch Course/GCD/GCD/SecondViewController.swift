//
//  SecondViewController.swift
//  GCD
//
//  Created by mac on 15.12.2023.
//

import UIKit

class SecondViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //MARK: - Internal vars
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

    //MARK: - Life Cyce
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchImage()

        delay(3) {
            self.loginAlert()
        }
    }

    //MARK: - Internal logic
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

    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Registered?", message: "Enter login and password", preferredStyle: .alert)

        ac.addTextField { loginTextField in
            loginTextField.placeholder = "Login"
        }

        ac.addTextField { passwordTextField in
            passwordTextField.placeholder = "Passworg"
            passwordTextField.isSecureTextEntry = true
        }

        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            guard let login = ac.textFields?.first?.text,
                  let password = ac.textFields?.last?.text
            else { return }

            print("login: \(login), password: \(password)")
        }

        ac.addAction(okAction)
        present(ac, animated: true)
    }

    fileprivate func delay(_ delay: Int, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            completion()
        }
    }
}
