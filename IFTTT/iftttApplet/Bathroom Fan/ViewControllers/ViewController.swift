//
//  ViewController.swift
//  Bathroom Fan
//
//  Created by Alexa Francis on 5/22/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct Constants {
        static let spacing: CGFloat = 16.0
        static let verticalMargin: CGFloat = 100.0
    }
    var myDataSource: [Applet] = MockData.data
//    {
//        var dataArray = [Applet]()
//        var channelDataSource = ["one", "two", "three", "four"]
//        for string in channelDataSource {
//            dataArray.append(Applet(id: string, created: string, serviceSlug: string, serviceOwner: string, name: string, description: string, brandColor: string, status: string, author: string, installCount: string, backgroundImages: string, userFeedback: string, channels: [Channel]()))
//        }
//        guard let applets: [Applet] = MockData.data else {
//            print("failed to decode the json for applet \(data)")
//            return dataArray
//        }
//        return applets
//    }()

    var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.spacing
        return stack
    }()
    var numButtons = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(self.stackView)
        self.addConstraints()
        if self.numButtons < self.myDataSource.count {
            self.addButtons()
        }
    }
    
    private func addButtons() {
        for applet in self.myDataSource {
            self.numButtons += 1
            let applet = AppletView(applet: applet)
            
//            let button = UIButton(type: .custom)
            applet.clipsToBounds = true
            applet.layer.cornerRadius = 16.0
            applet.backgroundColor = .lightGray
//            button.titleLabel?.textColor = .white
//            button.setTitle("\(title.author) /n\(title.id) /n\(title.id) /n\(title.id)", for: .normal)
//            button.setTitleColor(.white, for: .normal)
//            button.addTarget(self, action: #selector(self.tappedButton(_:)), for: .touchDown)
            self.stackView.addArrangedSubview(applet)
        }
    }

    @objc func tappedButton(_ button: UIButton) {
//        guard let title = button.titleLabel?.text else {
//            self.present(PlayingSoundViewController(soundTitle: "FAILED BUTTON TITLE"), animated: true)
            return
//        }
//        self.present(PlayingSoundViewController(soundTitle: title), animated: true)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.spacing),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.spacing),
            self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.verticalMargin),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Constants.verticalMargin)
            ])
        self.stackView.distribution = .fillEqually
    }
    
    
}
