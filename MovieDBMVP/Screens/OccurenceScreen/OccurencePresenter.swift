//
//  OccurencePresenter.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 22.01.2024.
//

import Foundation

protocol OccurenceViewPresentationLogic: AnyObject {
    func calculateOccurence()
}

final class OccurenceViewPresenter: OccurenceViewPresentationLogic {
    weak var controller: OccurenceViewDisplayLogic?
    private var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func calculateOccurence() {
        controller?.showLoading(isLoading: true)
        let arrangedTitle = title.replacingOccurrences(of: " ", with: "").lowercased()
        let characters = Array(arrangedTitle)
        var dataDictionary: [String:Int] = [:]
        characters.forEach { character in
            let char = String(character)
            
            if let value = dataDictionary[char] {
                let newValue = value + 1
                dataDictionary[char] = newValue
            } else {
                dataDictionary[char] = 1
            }
            
        }
        
        let occurenceModel: [OccurenceModel] = dataDictionary.map {
            return .init(character: $0.key, value: String($0.value))
        }
        
        let displayModel:OccurenceViewDisplayModel = .init(data: occurenceModel, title: title)
        controller?.display(displayModel)
        controller?.showLoading(isLoading: false)
    }
    
}
