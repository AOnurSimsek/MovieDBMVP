//
//  HomeViewDisplayModel.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 20.01.2024.
//

import Foundation

struct HomeViewDisplayModel {
    private var data: [MovieResultResponseModel]
    
    init(data: [MovieResultResponseModel] = []) {
        self.data = data
    }
    
    func getRowCount() -> Int {
        return data.count
    }
    
    func getData(at index: Int) -> MovieResultResponseModel {
        return data[index]
    }
    
    func getAllData() -> [MovieResultResponseModel] {
        return data
    }
    
    mutating func addMoreData(data: [MovieResultResponseModel]) {
        self.data.append(contentsOf: data)
    }
    
}
