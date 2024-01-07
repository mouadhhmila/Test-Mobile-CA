//
//  UIViewController+Extensions.swift
//  Test Mobile CA
//
//  Created by Mouadh Hmila on 4/1/2024.
//
import UIKit


extension UIViewController {
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    static let myColor = UIColor(displayP3Red: 0.0, green: 0.7, blue: 0.0, alpha: 1.0)
   
}

