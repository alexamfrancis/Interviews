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
    
    private lazy var cancelButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissView))
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
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints()
        self.view.layer.cornerRadius = UIScreen.main.bounds.width * 1.2
        self.view.backgroundColor = self.applet.status == .enabled ? .orangeAppletBackgroundColor
            : .disabledAppletBackgroundColor
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissView))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
//        self.navigationController?.navigationBar.setItems([UINavigationItem(title: "DONE BITCH")], animated: true)
//            self.navigationController?.navigationBar.setItems([UIBarButtonItem(title: "DONE BITCH", style: .done, target: self, action: #selector(self.dismissView))], animated: true)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.dismissView))
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.dismissView))
        
//        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissView))
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.view.centerXAnchor.constraint(equalTo: self.view.superview?.centerXAnchor),
            self.view.centerYAnchor.constraint(equalTo: self.view.superview?.centerYAnchor),
            self.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            self.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
            ])
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}
