//
//  AlertUtils.swift
//  SBTest
//
//  Created by AkbarPuteraW on 17/09/21.
//

import UIKit

class AlertUtils : NSObject {
    static func showCustomAlert(
        _ viewController: UIViewController,
        title: String?,
        message: String?,
        
        label_agree: String = "OK",
        label_disagree: String? = nil,
        label_close: String? = nil,
        
        agree: @escaping () -> Void = {},
        disagree: @escaping () -> Void = {},
        close: @escaping () -> Void = {}
    ) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: label_agree, style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            agree()
        }))
        
        if let label_disagree = label_disagree {
            alert.addAction(UIAlertAction(title: label_disagree, style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                disagree()
            }))
        }
        
        if let label_close = label_close {
            alert.addAction(UIAlertAction(title: label_close, style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                close()
            }))
        }
        viewController.present(alert, animated: true, completion: nil)
    }
}
