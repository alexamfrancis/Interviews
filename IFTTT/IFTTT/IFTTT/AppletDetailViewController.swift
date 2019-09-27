//
//  AppletDetailViewController.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/24/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class AppletDetailViewController: UIViewController {
    private struct Constants {
        /// Margin from right anchor of safe area to right anchor of Image
        static let collectionViewVerticalInset: CGFloat = 2.0
        static let standardSpacing: CGFloat = 8.0
        static let standardMargin: CGFloat = 32.0
        static let iconDimensions: CGFloat = 44.0
    }
    
    var applet: Applet

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
    
    var idLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    
    var labelStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    var channelStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var doneButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissView))
    }()

    private lazy var diameter: CGFloat = {
        return UIScreen.main.bounds.width * 0.8
    }()

    init(_ applet: Applet) {
        self.applet = applet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = .zero
        self.viewWillLayoutSubviews()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints()
        self.view.layer.cornerRadius = self.diameter / 2
        self.view.backgroundColor = self.applet.status == .enabled ? .orangeAppletBackgroundColor
            : .disabledAppletBackgroundColor
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissView))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        self.navigationItem.rightBarButtonItem = self.doneButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.clipsToBounds = true
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints()
        self.view.layer.cornerRadius = self.diameter / 2
    }
    
    private func addConstraints() {
        self.view.removeConstraints(self.view.constraints)
        guard let navigationView = self.navigationController?.view else {
            print("no navigation view controller in the applet detail screen")
            return
        }
        NSLayoutConstraint.activate([
            self.view.widthAnchor.constraint(equalToConstant: self.diameter),
            self.view.heightAnchor.constraint(equalToConstant: self.diameter)
            ])
        self.view.bounds = CGRect(x: navigationView.frame.width - self.diameter, y: navigationView.frame.minY + self.diameter, width: self.diameter, height: self.diameter)
        self.viewDidLayoutSubviews()
    }
    
    private func configureLabels() {
        guard let channels = self.applet.channels else { return }
        for channel in channels {
            let image = UIImage(contentsOfFile: channel.image_url)
            self.channelStackView.addArrangedSubview(UIImageView(image: image))
        }
        self.nameLabel.text = self.applet.name
        self.idLabel.text = self.applet.id
        self.authorLabel.text = self.applet.author
        self.idLabel.text = self.applet.id
        self.descriptionLabel.text = self.applet.description
        
        self.labelStackView.addArrangedSubview(self.nameLabel)
        self.labelStackView.addArrangedSubview(self.idLabel)
        self.labelStackView.addArrangedSubview(self.authorLabel)
        self.labelStackView.addArrangedSubview(self.channelStackView)
        self.labelStackView.addArrangedSubview(self.descriptionLabel)
        self.view.addSubview(self.labelStackView)
        
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}
