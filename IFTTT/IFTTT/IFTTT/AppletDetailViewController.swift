//
//  AppletDetailViewController.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/24/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class Label: UILabel {
    init(fontStyle: UIFont.TextStyle = .body) {
        super.init(frame: .infinite)
        self.textColor = .white
        self.autoresizesSubviews = true
        self.textAlignment = .center
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.font = UIFont.preferredFont(forTextStyle: fontStyle)
        self.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        self.adjustsFontForContentSizeCategory = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AppletDetailViewController: UIViewController {
    private lazy var diameter: CGFloat = {
        return UIScreen.main.bounds.width * 1.2
    }()

    var applet: Applet
    var nameLabel = Label(fontStyle: .headline)
    var authorLabel = Label(fontStyle: .subheadline)
    var idLabel = Label(fontStyle: .caption1)
    var descriptionLabel = Label()
    var channelStackView: UIStackView?

    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constants.standardSpacing
        stackView.distribution = .fillProportionally
        stackView.autoresizesSubviews = true
        return stackView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    private lazy var doneButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissView))
    }()

    
    init(_ applet: Applet) {
        self.applet = applet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addDismissGestures()
        self.setupChannelsHorizontalStackView()
        self.configureLabels()
        self.setupVerticalStackView()
    }
    
    private func setupChannelsHorizontalStackView() {
        if let channels = self.applet.channels {
            let iconURLs = channels.map{ $0.image_url }
            var icons = [UIImageView]()
            icons = iconURLs.map { self.getImage(from: $0) }
            self.channelStackView = UIStackView(arrangedSubviews: icons)
            self.channelStackView?.backgroundColor = .clear
            self.channelStackView?.axis = .horizontal
            self.channelStackView?.alignment = .top
            self.channelStackView?.spacing = Constants.standardMargin
            self.channelStackView?.layoutSubviews()
        }
    }
    
    private func setupVerticalStackView() {
        self.viewWillLayoutSubviews()
        self.view.setNeedsLayout()
        self.backgroundView.addSubview(self.labelStackView)
        self.view.addSubview(self.backgroundView)
        self.addSubviewConstraints()
        self.backgroundView.layer.cornerRadius = self.diameter / 2
        self.backgroundView.layer.backgroundColor = self.applet.status ?? .disabled == .enabled ? UIColor.orangeAppletBackgroundColor.cgColor : UIColor.disabledAppletBackgroundColor.cgColor
        self.backgroundView.backgroundColor = self.applet.status == .enabled ? .orangeAppletBackgroundColor : .disabledAppletBackgroundColor
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
    }
    
    private func configureLabels() {
        self.nameLabel.text = self.applet.name
        self.authorLabel.text = self.applet.author
        self.descriptionLabel.text = self.applet.description
        self.idLabel.text = self.applet.id

        self.labelStackView.addArrangedSubview(self.nameLabel)
        self.labelStackView.addArrangedSubview(self.authorLabel)
        if let channels = self.channelStackView { self.labelStackView.addArrangedSubview(channels) }
        self.labelStackView.addArrangedSubview(self.descriptionLabel)
        self.idLabel.text = "ID: \(self.applet.id ?? "unknown")" // NOTE: All variables should be localized with a `Localization class` so any string could be translated — e.g. "\(self.myString.localized)"
        self.labelStackView.addArrangedSubview(self.idLabel)
    }

    private func addSubviewConstraints() {
        NSLayoutConstraint.activate([
            self.backgroundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.backgroundView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.backgroundView.widthAnchor.constraint(equalToConstant: self.diameter),
            self.backgroundView.heightAnchor.constraint(equalToConstant: self.diameter),
            self.labelStackView.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
            self.labelStackView.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor),
            self.labelStackView.widthAnchor.constraint(equalToConstant: self.diameter / 1.5),
            self.labelStackView.heightAnchor.constraint(equalToConstant: self.diameter / 1.5)
            ])
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getImage(from url: String) -> UIImageView {
        guard let data: Data = try? Data(contentsOf: URL(string: url)!), let image = UIImage(data: data) else {
            print("failed to decode the data from the contents of the file URL path")
            return UIImageView(image: UIImage(imageLiteralResourceName: "icon"))
        }
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: Constants.iconDimensions),
            imageView.widthAnchor.constraint(equalToConstant: Constants.iconDimensions)
            ])
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.iconDimensions / 2
        return imageView
    }

    private func addDismissGestures() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissView))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        self.navigationItem.rightBarButtonItem = self.doneButtonItem
    }
}
