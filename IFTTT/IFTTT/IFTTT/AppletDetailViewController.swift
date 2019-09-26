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
    
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}
