//
//  DetailViewDisplayModel.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 22.01.2024.
//

import Foundation

enum DetailViewCellTypes: CaseIterable {
    case imageAndTitle
    case overview
    case genre
    case vote
    case releaseDate
    case imdbButton
}

struct DetailViewDisplayModel {
    private var data: MovieDetailResponseModel?
    private var sections: [DetailViewCellTypes] = DetailViewCellTypes.allCases
    
    init(data: MovieDetailResponseModel? = nil) {
        self.data = data
    }
    
    func getSectionType(at section: Int) -> DetailViewCellTypes {
        return sections[section]
    }
    
    func getSectionCount() -> Int {
        return (data == nil) ? 0 : sections.count
    }
    
    func getRowCount() -> Int {
        return 1
    }
    
    func getAllData() -> MovieDetailResponseModel? {
        return data
    }
    
    func getCellData(type: DetailViewCellTypes) -> Any {
        switch type {
        case .imageAndTitle:
            let model:ImageTableViewCellDisplayModel = .init(imagePath: data?.backdropPath,
                                                             title: data?.originalTitle)
            return model
            
        case .overview:
            let model: InformationTableViewCellDisplayModel = .init(text: data?.overview)
            return model
            
        case .genre:
            var genres: String = ""
            data?.genres?.forEach({  genres += ($0.name ?? "") + " "  })
            let model: InformationTableViewCellDisplayModel = .init(text: genres)
            return model
            
        case .vote:
            let vote: String = "Vote : " + String(format: "%.2f", data?.voteAverage ?? 0)
            let model: InformationTableViewCellDisplayModel = .init(text: vote)
            return model
            
        case .releaseDate:
            let date: String = "Release Date : " + (data?.releaseDate ?? "-")
            let model: InformationTableViewCellDisplayModel = .init(text: date)
            return model
            
        case .imdbButton:
            let model: ButtonTableViewCellDisplayModel = .init(text: "Visit IMDB Page")
            return model
            
        }
        
    }
    
    func getImdbId() -> String? {
        return data?.imdbId
    }
    
}
