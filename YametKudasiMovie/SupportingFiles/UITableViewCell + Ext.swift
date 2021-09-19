//
//  UITableViewCell + Ext.swift
//  SBTest
//
//  Created by AkbarPuteraW on 17/09/21.
//

import UIKit

extension UITableViewCell {
    class var identifier : String {
        return "\(self)"
    }
    
    class var nib : UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    static func registerTo(tableView: UITableView) {
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    static func dequeue(tableView: UITableView, indexPath: IndexPath) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! Self
    }
}
