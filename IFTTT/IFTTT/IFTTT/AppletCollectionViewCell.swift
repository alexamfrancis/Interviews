//
//  AppletCollectionViewCell.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/20/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class AppletCollectionViewCell: UICollectionViewCell {    
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
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()

    var applet: Applet?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func configure(applet: Applet) {
        self.applet = applet
        self.backgroundColor = self.applet?.status ?? .disabled == .enabled ? .orangeAppletBackgroundColor : .disabledAppletBackgroundColor

        self.nameLabel.text = applet.name
        self.authorLabel.text = applet.author
        self.iconImage.image = self.getImage()

        self.addSubview(self.iconImage)
        self.stackView.addArrangedSubview(self.nameLabel)
        self.stackView.addArrangedSubview(self.authorLabel)
        self.stackView.addArrangedSubview(self.channelsButton)
        self.addSubview(self.stackView)
        
        self.addConstraints()
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
            self.iconImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.standardMargin),
            self.iconImage.heightAnchor.constraint(equalToConstant: Constants.iconDimensions),
            self.iconImage.widthAnchor.constraint(equalToConstant: Constants.iconDimensions),
            
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.inset),
            self.stackView.leadingAnchor.constraint(equalTo: self.iconImage.trailingAnchor, constant: Constants.standardSpacing),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.inset),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.inset)
        ])
    }

}
