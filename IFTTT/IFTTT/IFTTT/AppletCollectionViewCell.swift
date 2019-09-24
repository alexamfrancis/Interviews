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
        static let standardMargin: CGFloat = 16.0
        static let iconDimensions: CGFloat = 10.0
        static let diameter: CGFloat = 44.0
    }

    var idLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MY APPLET ID"
        label.textColor = .red
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MY APPLET"
        label.textColor = .red
        return label
    }()
    
    var authorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ALEXA FRANCIS"
        label.textColor = .red
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DESCRIPTION"
        label.textColor = .red
        return label
    }()
    
    var iconImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.backgroundColor = .clear
        image.layer.cornerRadius = Constants.iconDimensions / 2
        return image
    }()
    
    var applet: Applet?
    
    func configure(applet: Applet) {
        self.applet = applet
        self.formatCell()
        
        self.nameLabel.text = applet.name
        self.authorLabel.text = applet.author
        self.iconImage.image = self.getImage()
        
        self.addSubview(self.iconImage)
        self.addSubview(self.nameLabel)
        self.addSubview(self.authorLabel)
        self.addConstraints()
    }
    
    func formatCell() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = Constants.diameter / 2
        self.backgroundColor = .purple
        NSLayoutConstraint.activate([
            self.contentView.heightAnchor.constraint(equalToConstant: Constants.diameter),
            self.contentView.widthAnchor.constraint(equalToConstant: Constants.diameter),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
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
            self.iconImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.standardMargin),
            self.iconImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.standardMargin),
            self.iconImage.heightAnchor.constraint(equalToConstant: Constants.iconDimensions),
            self.iconImage.widthAnchor.constraint(equalToConstant: Constants.iconDimensions),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.standardMargin),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.iconImage.trailingAnchor, constant: Constants.standardMargin),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.standardMargin),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.authorLabel.topAnchor, constant: -Constants.standardMargin),
            
            self.authorLabel.leadingAnchor.constraint(equalTo: self.iconImage.trailingAnchor, constant: Constants.standardMargin),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.standardMargin),
            self.authorLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.standardMargin)
            
            ])
    }

}
