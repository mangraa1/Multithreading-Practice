//
//  ViewController.swift
//  GCD
//
//  Created by mac on 11.08.2023.
//

import UIKit

class FirstViewController: UIViewController {

    //MARK: Variables

    private var pressButton = UIButton()

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "First VC"

        initButton()

        pressButton.addTarget(self, action: #selector(pressAction), for: .touchUpInside)
    }

    //MARK: - UI

    private func initButton() {
        pressButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        pressButton.center = view.center

        pressButton.backgroundColor = .systemBlue
        pressButton.setTitle("Press", for: .normal)
        pressButton.setTitleColor(.white, for: .normal)
        pressButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        pressButton.layer.cornerRadius = 10
        pressButton.layer.borderWidth = 1
        pressButton.layer.borderColor = UIColor.black.cgColor

        view.addSubview(pressButton)
    }

    //MARK: - Actions

    @objc func pressAction() {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

