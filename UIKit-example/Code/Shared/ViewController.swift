//
//  ViewController.swift
//  UIKitExample
//
//  Created by Damiaan Dufaux on 10/07/2023.
//

import UIKit
import THEOliveSDK

class ViewController: UIViewController {
    var playerViewController: PlayerViewController?
    
    @IBOutlet weak var channelTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for controller in children {
            if let playerController = controller as? PlayerViewController {
                playerViewController = playerController
                break
            }
        }
    }
    
    @IBAction func loadChannelPressed(_ sender: Any) {
        if let channelID = channelTextField.text {
            print("Load channelID", channelID)
            Task {
                try await playerViewController?.player.loadChannel(channelID)
            }
        }
    }
    
    @IBAction func resetChannelPressed(_ sender: Any) {
        playerViewController?.player.reset()
    }
}
