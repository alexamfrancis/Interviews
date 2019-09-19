//
//  PlayingSoundViewController.swift
//  Bathroom Fan
//
//  Created by Alexa Francis on 5/22/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class PlayingSoundViewController: UIViewController {
    private struct Constants {
        static let margin: CGFloat = 40.0
        static let height: CGFloat = 100.0
    }
    
    var soundTitle: String
    var stopButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        button.backgroundColor = .red
        return button
    }()
    
    init(applet: Applet) {
        self.soundTitle = applet.name ?? "ALEXA NAME FAILED"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupStopButton()
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
        self.dismiss(animated: true)
    }
}
