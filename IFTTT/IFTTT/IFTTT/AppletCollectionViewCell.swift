//
//  AppletCollectionViewCell.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/20/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class AppletCollectionViewCell: UICollectionViewCell {
    struct Constants {
        static let standardMargin: CGFloat = 32.0
        static let spacing: CGFloat = 8.0
        static let iconDimensions: CGFloat = 44.0
        static let diameter: CGFloat = UIScreen.main.bounds.width / 1.5
    }
    
    var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var authorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    var channelsButton: UIButton = {
        let channelsButton = UIButton(type: .custom)
        channelsButton.setTitle("View Channels", for: .normal)
        channelsButton.setTitleColor(.blue, for: .normal)
        channelsButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return channelsButton
    }()
    
    var iconImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.backgroundColor = .clear
        image.layer.cornerRadius = Constants.iconDimensions / 2
        return image
    }()

    var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()

    var applet: Applet?
    
    func configure(applet: Applet) {
        self.applet = applet
        self.formatCell()
        
        self.nameLabel.text = applet.name
        self.authorLabel.text = applet.author
        self.iconImage.image = self.getImage()
        self.channelsButton.addTarget(self, action: #selector(self.showChannels), for: UIControl.Event.touchDown)

        self.addSubview(self.iconImage)
        self.stackView.addArrangedSubview(self.nameLabel)
        self.stackView.addArrangedSubview(self.authorLabel)
        self.stackView.addArrangedSubview(self.channelsButton)
        self.addSubview(self.stackView)
        
        self.addConstraints()
    }
    @objc func showChannels() {
        let channels: [String] = self.applet?.channels?.map({ channel -> String in
            return channel.name
        }) ?? []
        self.channelsButton.setTitle(channels.joined(separator: ", ") , for: .normal)
    }
    func formatCell() {
        self.clipsToBounds = true
        self.layer.cornerRadius = Constants.diameter / 2
        self.backgroundColor = self.applet?.status ?? .disabled == .enabled ? .orangeAppletBackgroundColor : .disabledAppletBackgroundColor
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.diameter),
            self.widthAnchor.constraint(equalToConstant: Constants.diameter)
            ])
        
    }
    
    private func getImage() -> UIImage {
        guard let applet = self.applet, let data: Data = try? Data(contentsOf: URL(string: applet.channels?.first?.image_url ?? "https://assets.ifttt.com/images/channels/651849913/icons/regular.png") ?? URL(fileURLWithPath: "/Users/alexafrancis/Documents/Personal/Interviews/Interviews/IFTTT/iftttApplet/Bathroom Fan/Resources/appletData.json")), let image = UIImage(data: data) else {
            print("failed to decode the data from the contents of the file URL path")
            return UIImage(imageLiteralResourceName: "icon")
        }
        return image
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            self.iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.iconImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.spacing),
            self.iconImage.heightAnchor.constraint(equalToConstant: Constants.iconDimensions),
            self.iconImage.widthAnchor.constraint(equalToConstant: Constants.iconDimensions),
            
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.standardMargin),
            self.stackView.leadingAnchor.constraint(equalTo: self.iconImage.trailingAnchor, constant: Constants.spacing),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.standardMargin),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.standardMargin)
        ])
    }

}
