//
//  ViewController.swift
//  UIKitExample
//
//  Created by Damiaan Dufaux on 27/07/2023.
//

import UIKit
import THEOliveSDK

class ViewController: UIViewController {
    
    let player: THEOlivePlayer
    let playerViewController: THEOlivePlayerViewController
    let printer = EventPrinter()
    
    required init?(coder: NSCoder) {
        player = THEOlivePlayer()
        playerViewController = THEOlivePlayerViewController(player: player)
        super.init(coder: coder)
        
        player.add(eventListener: printer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playerView = playerViewController.view!
        let textField = UITextField()
        let stackView = UIStackView(arrangedSubviews: [playerView, textField])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Fill in your channelID"
        let loadChannel = UIAction { [unowned self] action in
            if let textField = action.sender as? UITextField, let id = textField.text {
                self.player.loadChannel(id)
                self.view.endEditing(false)
            }
        }
        textField.addAction(loadChannel, for: .primaryActionTriggered)
        
        addChild(playerViewController)
        view.addSubview(stackView)
        playerViewController.didMove(toParent: self)
        
        layout(textField: textField, playerView: playerView, stackView: stackView)
    }

    func layout(textField: UITextField, playerView: UIView, stackView: UIStackView) {
        stackView.axis = .vertical
        textField.borderStyle = .roundedRect
        
        let safeArea = view.safeAreaLayoutGuide
        let aspectRatio = playerView.widthAnchor.constraint(equalTo: playerView.heightAnchor, multiplier: 16/9)
        aspectRatio.priority = .defaultLow
        aspectRatio.isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: safeArea.leadingAnchor, multiplier: 1).isActive = true
        safeArea.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1).isActive = true
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: safeArea.topAnchor, multiplier: 1).isActive = true
        #if os(iOS)
        let bottomAnchor: NSLayoutYAxisAnchor
        if #available(iOS 15.0, *) {
            bottomAnchor = view.keyboardLayoutGuide.topAnchor
        } else {
            bottomAnchor = safeArea.bottomAnchor
        }
        #else
        let bottomAnchor = safeArea.bottomAnchor
        #endif
        bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor, constant: 8).isActive = true
    }
}

class EventPrinter: THEOlivePlayerEventListener {
    func onChannelLoadStart(channelId: String) {
        print("THEOlive loading channel", channelId)
    }
    
    func onWaiting() {
        print("THEOlive Waiting")
    }
    
    func onPause() {
        print("THEOlive paused")
    }
    
    func onVolumeChange() {
        print("THEOlive volume change")
    }
}
