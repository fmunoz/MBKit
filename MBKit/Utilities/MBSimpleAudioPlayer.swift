//
//  MBSimpleAudioPlayer.swift
//  MBKit
//
//  Created by Franklin Munoz on 2/15/18.
//  Copyright © 2018 Magic Box Software Solutions LLC. All rights reserved.
//

import AVFoundation

@objc open class MBSimpleAudioPlayer:NSObject, AVAudioPlayerDelegate {
    
    private var players: [AVAudioPlayer: (Any?, (Any?)->Void)] = [:]
    
    public init(category: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(category)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            MBLog.shared.print(message: error.localizedDescription)
        }
    }

    deinit {
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch let error {
            MBLog.shared.print(message: error.localizedDescription)
        }
    }
    
    public func play (from url:URL) -> Bool {
        return self.play(from: url, completionCookie: nil, completionHandler: nil)
    }
    
    public func play(from url:URL, completionCookie: Any?, completionHandler: (( Any?)-> Void)?) -> Bool {
        do {
            let player = try AVAudioPlayer(contentsOf: url)

            if let completionHandler = completionHandler {
                players[player] = (completionCookie, completionHandler)
                player.delegate = self
            }
            return player.play()

        } catch let error {
            MBLog.shared.print(message: error.localizedDescription)
            return false
        }
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        if let handlerEntry = players[player] {
            players.removeValue(forKey: player)
            handlerEntry.1(handlerEntry.0)
        }
    }
    
    
}
