//
//  BaseView.swift
//  SwiftApp
//
//  Created by WYH_MAC001 on 05/09/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit

class BaseView: UIViewController {

    var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String?, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func startActivityIndicatory(uiView: UIView) {
        let loadingView: UIView = UIView()
        loadingView.frame =  CGRect(x: 0, y: 0, width: 80.0, height: 80.0)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 0.8)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        actInd.frame = CGRect(x: 0, y: 0, width: 40.0, height: 40.0)
        if #available(iOS 13.0, *) {
            actInd.style = UIActivityIndicatorView.Style.large
        } else {
            actInd.style = UIActivityIndicatorView.Style.whiteLarge
        }
        actInd.color = .white
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        self.view.addSubview(loadingView)
        actInd.startAnimating()
    }
    
    func stopActivityIndicator() {
        actInd.stopAnimating()
        let view = actInd.superview
        view?.removeFromSuperview()
    }
}
