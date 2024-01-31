//
//  OccurenceViewBuilder.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 31.01.2024.
//

import UIKit

final class OccurenceViewBuilder {
    func createOccurenceScreen(with title: String) -> UIViewController {
        let presenter = OccurenceViewPresenter(title: title)
        let controller = OccurenceViewController(presenter: presenter)
        
        presenter.controller = controller
        
        return controller
    }
    
}
