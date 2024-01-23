//
//  OccurenceDisplayModel.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 22.01.2024.
//

import Foundation

struct OccurenceModel {
    let character: String
    let value: String
}

struct OccurenceViewDisplayModel {
    private var data: [OccurenceModel]
    private var title: String
    
    init(data: [OccurenceModel] = [],
         title: String = "") {
        self.data = data
        self.title = title
    }
    
    func getRowCount() -> Int {
        return (data.count == 0) ? 0 : data.count + 1
    }
    
    func getData(at index: Int) -> OccurenceModel {
        return data[index]
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getAllData() -> [OccurenceModel] {
        return data
    }
    
}
