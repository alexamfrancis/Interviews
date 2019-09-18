//
//  AppletCollectionViewCell.swift
//  Applet IFTTT
//
//  Created by Alexa Francis on 9/18/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class AppletCollectionViewCell: UICollectionViewCell {
    var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .purple
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    var idLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MY APPLET"
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
    
    init(id: String, name: String, author: String, description: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50.0)
        self.widthAnchor.constraint(equalToConstant: 50.0)
        self.formatCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func formatCell() {
        self.stackView.addSubview(self.nameLabel)
        self.stackView.addSubview(self.authorLabel)
        self.stackView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.stackView)
        self.addConstraints()
        self.backgroundColor = .lightGray
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            self.heightAnchor.constraint(equalToConstant: 50),
//            self.widthAnchor.constraint(equalToConstant: 50),
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
}
