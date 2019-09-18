//
//  ViewController.swift
//  Bathroom Fan
//
//  Created by Alexa Francis on 5/22/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

enum SoundType: String {
    case fan
    case water
    case misc
}

enum MiscellaneousSoundType: UInt32 {
    case poop
    case taylorSwift
    case sex
    case fart
    case harryPotter
    
    var string: String {
        switch self {
        case .poop:
            return "poop"
        case .taylorSwift:
            return "taylorSwift"
        case .sex:
            return "sex"
        case .fart:
            return "fart"
        case .harryPotter:
            return "harryPotter"
        }
    }
    
    static func random() -> MiscellaneousSoundType {
        // Update as new enumerations are added
        let maxValue = self.harryPotter.rawValue
        print(maxValue+1)
        let rand = arc4random_uniform(maxValue+1)
        return MiscellaneousSoundType(rawValue: rand)!
    }

}

class ViewController: UIViewController {
    
    struct Constants {
        static let horizontalMargin: CGFloat = 16.0
        static let verticalMargin: CGFloat = 100.0
        static let soundTypeTitles: [String] = ["fan", "water", "misc"]
    }
    var myDataSource: [Applet] = {
        var dataArray = [Applet]()
        var channelDataSource = ["one", "two", "three", "four"]
        for string in channelDataSource {
            dataArray.append(Applet(id: string, created: string, serviceSlug: string, serviceOwner: string, name: string, description: string, brandColor: string, status: string, author: string, installCount: string, backgroundImages: string, userFeedback: string))
        }
        return dataArray
    }()

    var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.horizontalMargin
        return stack
    }()
    var numButtons = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(self.stackView)
        self.addConstraints()
        if self.numButtons < 10 {
            self.addButtons()
        }
    }
    
    private func addButtons() {
        for title in Constants.soundTypeTitles {
            self.numButtons += 1
            let button = UIButton(type: .custom)
            button.clipsToBounds = true
            button.layer.cornerRadius = 10.0
            button.backgroundColor = .blue
            button.titleLabel?.textColor = .white
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(self.tappedButton(_:)), for: .touchDown)
            self.stackView.addArrangedSubview(button)
        }
    }

    @objc func tappedButton(_ button: UIButton) {
        guard let titleLabel = button.titleLabel, var text = titleLabel.text else { return }
        if text == SoundType.misc.rawValue {
            text = MiscellaneousSoundType.random().string
        }
        self.present(PlayingSoundViewController(soundTitle: text), animated: true)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.horizontalMargin),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.horizontalMargin),
            self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.verticalMargin),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Constants.verticalMargin)
            ])
        self.stackView.distribution = .fillEqually
    }
    
    
}
