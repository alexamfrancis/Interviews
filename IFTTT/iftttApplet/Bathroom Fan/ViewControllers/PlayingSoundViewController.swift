//
//  PlayingSoundViewController.swift
//  Bathroom Fan
//
//  Created by Alexa Francis on 5/22/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit
import AVFoundation

class PlayingSoundViewController: UIViewController {
    private struct Constants {
        static let margin: CGFloat = 40.0
        static let height: CGFloat = 100.0
    }
    
    var player: AVAudioPlayer?
    var soundTitle: String
    var stopButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        button.backgroundColor = .red
        return button
    }()
    
    init(soundTitle: String) {
        self.soundTitle = soundTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupStopButton()
        self.player?.numberOfLoops = -1
        guard let url = Bundle.main.url(forResource: self.soundTitle, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = self.player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    private func setupStopButton() {
        self.stopButton.setTitle("Stop Sound", for: .normal)
        self.stopButton.setTitleColor(.white, for: .normal)
        self.view.addSubview(self.stopButton)
        NSLayoutConstraint.activate([
            self.stopButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stopButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stopButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.margin),
            self.stopButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.margin),
            self.stopButton.heightAnchor.constraint(equalToConstant: Constants.height)
            ])
        self.stopButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.stopSound)))
    }
    
    @objc private func stopSound() {
        self.player?.stop()
        self.dismiss(animated: true)
    }
}
