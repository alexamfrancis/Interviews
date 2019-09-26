//
//  AppletDetailViewController.swift
//  IFTTT
//
//  Created by Alexa Francis on 9/24/19.
//  Copyright © 2019 Alexa Francis. All rights reserved.
//

import UIKit

class AppletDetailViewController: UIViewController {
    var applet: Applet
    
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
        self.view.clipsToBounds = true
        self.view.backgroundColor = .disabledAppletBackgroundColor
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints()
        self.view.layer.cornerRadius = UIScreen.main.bounds.width / 2
        self.view.backgroundColor = self.applet.status == .enabled ? .orangeAppletBackgroundColor
            : .disabledAppletBackgroundColor
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissView))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        self.navigationItem.rightBarButtonItem = self.doneButtonItem
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
//            self.view.centerXAnchor.constraint(equalTo: self.view.superview?.centerXAnchor),
//            self.view.centerYAnchor.constraint(equalTo: self.view.superview?.centerYAnchor),
            self.view.widthAnchor.constraint(equalToConstant: self.diameter),
            self.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
            ])
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}
