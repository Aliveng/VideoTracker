//
//  NewsService.swift
//  VideoTracker
//
//  Created by Кирилл Худяков on 18.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//


//enum NewsServiceError {
//
//}
import Foundation

extension TimeInterval {
    static let hour: TimeInterval = 3600
    static let day: TimeInterval = 3600 * 24
}


protocol NewsService {
    func getNewsItems(_ completion: (Result<[NewsItem], Error>) -> Void)
}

