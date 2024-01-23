//
//  UIAlertManager.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 21.01.2024.
//

import UIKit

final class UIAlertManager {
    static let shared = UIAlertManager()
    
    func getSimpleAlertController(title: String = "Error", message: String) -> UIAlertController {
        let alertContoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertContoller.addAction(UIAlertAction(title: "Ok",
                                               style: .default,
                                               handler: nil))
        return alertContoller
    }
    
}
