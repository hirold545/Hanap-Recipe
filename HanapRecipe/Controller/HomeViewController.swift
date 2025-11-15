//
//  ViewController.swift
//  HanapRecipe
//
//  Created by test test on 11/6/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateText("HANAP SANGKAP", label: titleLabel)
    }
    
    func animateText(_ text: String, label: UILabel, interval: TimeInterval = 0.10) {
        label.text = ""
        var charIndex = 0.0
        for letter in text {
            Timer.scheduledTimer(withTimeInterval: interval * charIndex, repeats: false) { _ in
                label.text?.append(letter)
            }
            charIndex += 1
        }
    }

    @IBAction func startButton(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoMain", sender: self)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let tabBar = storyboard.instantiateViewController(withIdentifier: "MainTabBar")
//        tabBar.modalPresentationStyle = .fullScreen
//        self.present(tabBar, animated: true)
    }
    
}

