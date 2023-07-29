//
//  PlayerView.swift
//  SwiftUI-example
//
//  Created by Damiaan Dufaux on 28/07/2023.
//

import SwiftUI
import THEOliveSDK

struct PlayerView: UIViewControllerRepresentable {
    let player: THEOlivePlayer

    func updateUIViewController(_ uiViewController: THEOlivePlayerViewController, context: Context) {}

    func makeUIViewController(context: Context) -> THEOlivePlayerViewController {
        THEOlivePlayerViewController(player: player)
    }
}

struct ChromelessPlayerView: UIViewControllerRepresentable {
    let player: THEOlivePlayer

    func updateUIViewController(_ uiViewController: THEOliveChromelessPlayerViewController, context: Context) {}

    func makeUIViewController(context: Context) -> THEOliveChromelessPlayerViewController {
        THEOliveChromelessPlayerViewController(player: player)
    }
}
