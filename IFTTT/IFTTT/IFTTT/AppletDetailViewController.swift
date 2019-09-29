//
//  AppletDetailViewController.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/24/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class Label: UILabel {
    init(rect: CGRect) {
        super.init(frame: .zero)
        self.textColor = .white
        self.autoresizesSubviews = true
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AppletDetailViewController: UIViewController {
    var applet: Applet

    var nameLabel: Label = {
        return Label(rect: .zero)
    }()
    
    var authorLabel: Label = {
        return Label(rect: .zero)
    }()
    
    var idLabel: Label = {
        return Label(rect: .zero)
    }()

    var descriptionLabel: Label = {
        return Label(rect: .zero)
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var channelStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.clipsToBounds = true
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
//        self.viewWillLayoutSubviews()
//        guard let navigationView = self.navigationController?.view else {
//            print("no navigation view controller in the applet detail screen")
//            return
//        }
//        self.view.clipsToBounds = true
//        self.view.frame = self.getViewFrame()
//        self.view.bounds = self.getViewFrame()
//        self.viewDidLayoutSubviews()
//        self.view.layer.masksToBounds = true
//        self.view.layer.cornerRadius = self.diameter / 2
//        self.view.backgroundColor = self.applet.status == .enabled ? .orangeAppletBackgroundColor
//            : .disabledAppletBackgroundColor
//        self.view.reloadInputViews()
//        self.view.clipsToBounds = true
//        self.view.layer.cornerRadius = self.diameter / 2
//        self.addConstraints()
        self.configureLabels()
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissView))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        self.navigationItem.rightBarButtonItem = self.doneButtonItem
//        self.addConstraints()
//        self.configureLabels()
//        self.viewDidLayoutSubviews()
//        self.view.reloadInputViews()
}
    
//    private func getViewFrame() -> CGRect {
//        let x = (UIScreen.main.bounds.width - self.diameter) / 2
//        let y = (UIScreen.main.bounds.height - self.diameter) / 2
//        return CGRect(x: x, y: y, width: diameter, height: diameter)
//    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.viewWillLayoutSubviews()
//        self.addConstraints()
//        self.configureLabels()
//        self.view.clipsToBounds = true
//        self.view.layer.cornerRadius = self.diameter / 2
//        self.view.backgroundColor = self.applet.status == .enabled ? .orangeAppletBackgroundColor
//            : .disabledAppletBackgroundColor
//        self.viewDidLayoutSubviews()

//        self.view.clipsToBounds = true
//        self.view.translatesAutoresizingMaskIntoConstraints = false
//        self.addConstraints()
//        self.view.layer.cornerRadius = self.diameter / 2
//    }
    
//    private func addConstraints() {
//        self.view.removeConstraints(self.view.constraints)
//        guard let navigationView = self.navigationController?.view else {
//            print("no navigation view controller in the applet detail screen")
//            return
//        }
//        NSLayoutConstraint.activate([
//            self.view.widthAnchor.constraint(equalToConstant: self.diameter),
//            self.view.heightAnchor.constraint(equalToConstant: self.diameter)
//            ])
//        self.view.frame = CGRect(x: navigationView.frame.width - self.diameter, y: navigationView.frame.minY + self.diameter, width: self.diameter, height: self.diameter)
//        self.viewDidLayoutSubviews()
//    }
    
    private func configureLabels() {
        self.nameLabel.text = self.applet.name
        self.idLabel.text = self.applet.id
        self.authorLabel.text = self.applet.author
        self.idLabel.text = self.applet.id
        self.descriptionLabel.text = self.applet.description
        
        
        self.labelStackView.addArrangedSubview(self.nameLabel)
        self.labelStackView.addArrangedSubview(self.idLabel)
        self.labelStackView.addArrangedSubview(self.authorLabel)
//        guard let channels = self.applet.channels else { return }
//        for channel in channels {
//            let image = UIImage(contentsOfFile: channel.image_url)
//            self.channelStackView.addSubview(UIImageView(image: image))
//        }
//        self.labelStackView.addSubview(self.channelStackView)
        self.labelStackView.addArrangedSubview(self.descriptionLabel)
        
        let button = UIButton(type: .roundedRect)
        button.setTitle("ALEXA FRANCIS", for: .normal)
        self.labelStackView.contentMode = .center
        self.labelStackView.addArrangedSubview(button)

        self.labelStackView.clipsToBounds = true
        self.labelStackView.layer.masksToBounds = true
        self.labelStackView.layer.cornerRadius = self.diameter / 2
        self.labelStackView.layer.backgroundColor = self.applet.status ?? .disabled == .enabled ? UIColor.orangeAppletBackgroundColor.cgColor : UIColor.disabledAppletBackgroundColor.cgColor
        self.labelStackView.backgroundColor = self.applet.status == .enabled ? .orangeAppletBackgroundColor : .disabledAppletBackgroundColor

        self.view.addSubview(self.labelStackView)
        self.addSubviewConstraints()

    }

    private func addSubviewConstraints() {
        NSLayoutConstraint.activate([
            self.labelStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.labelStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.labelStackView.widthAnchor.constraint(equalToConstant: self.diameter),
            self.labelStackView.heightAnchor.constraint(equalToConstant: self.diameter)
            ])
//        self.labelStackView.clipsToBounds = true
//        self.labelStackView.layer.masksToBounds = true
//        self.labelStackView.layer.cornerRadius = self.diameter / 2
//        self.view.setNeedsLayout()
//        self.view.layoutIfNeeded()
    }

    
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}
