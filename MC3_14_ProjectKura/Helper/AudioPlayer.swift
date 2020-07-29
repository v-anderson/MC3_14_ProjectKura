//
//  AudioPlayer.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 29/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import AVFoundation

class AudioPlayer {
    
    private var player: AVAudioPlayer?
    
    private let filename: String
    private let ext: String
    
    init(filename: String, extension ext: String) {
        self.filename = filename
        self.ext = ext
    }
    
    func setupAudioService() {
        guard let url = Bundle.main.url(forResource: filename, withExtension: ext) else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            player?.numberOfLoops = -1
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSound() {
        player?.stop()
        player?.volume = 0
        player?.prepareToPlay()
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.player?.play()
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] (timer) in
            guard let player = self?.player else { return }
            self?.player?.volume += 0.02
            
            if player.volume >= Float(1) {
                print("Sound played")
                timer.invalidate()
            }
        }
    }
    
    func stopSound() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] (timer) in
            guard let player = self?.player else { return }
            player.volume -= 0.1

            if player.volume <= Float(0) {
                print("Sound stopped")
                timer.invalidate()
                self?.player?.stop()
            }
        }
    }
    
    func lowerSound() {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] (timer) in
            self?.player?.volume -= 0.02
                        
            if let volume = self?.player?.volume {
                if volume <= Float(0.2) {
                    print("Sound lowered")
                    timer.invalidate()
                }
            }
        }
    }
}
