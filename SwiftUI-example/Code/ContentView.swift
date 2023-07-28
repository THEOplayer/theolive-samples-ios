//
//  ContentView.swift
//  SwiftUI-example
//
//  Created by Damiaan Dufaux on 28/07/2023.
//

import SwiftUI
import THEOliveSDK

struct ContentView: View {
    @State var player = THEOlivePlayer()

    var body: some View {
        TabView {
            ChromfullExample(player: player).tabItem {
                Label("Chromefull", systemImage: "play.rectangle")
            }
            ChromlessExample(player: player).tabItem {
                Label("Chromeless", systemImage: "rectangle.dashed")
            }
        }
        .padding()
    }
}

struct ChromfullExample: View {
    let player: THEOlivePlayer

    @State var channelId = ""
    
    var body: some View {
        VStack {
            PlayerView(player: player)
            TextField("Channel ID", text: $channelId)
            Button("Load channel") {
                player.loadChannel(channelId)
            }
        }.onDisappear(perform: player.reset)
    }
}

struct ChromlessExample: View {
    let player: THEOlivePlayer

    @State var channelId = ""
    
    var body: some View {
        VStack {
            ChromelessPlayerView(player: player)
            TextField("Channel ID", text: $channelId)
            Button("Load channel") {
                player.loadChannel(channelId)
            }
            Divider()
            HStack {
                Button("Play") {player.play()}
                Button("Pause") {player.pause()}
            }
        }.onDisappear(perform: player.reset)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
