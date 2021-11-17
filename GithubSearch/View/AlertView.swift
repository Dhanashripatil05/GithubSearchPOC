//
//  AlertView.swift
//  GithubSearch
//
//  Created by Dhanashri on 15/11/21.
//

import UIKit

class AlertView: NSObject {
    class func showAlert(view: UIViewController , message: String) {
        let alert = UIAlertController(title: Constants.ALERT_TITLE, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.ALERT_BUTTON, style: UIAlertAction.Style.default, handler: nil))
        
        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
    }
}
