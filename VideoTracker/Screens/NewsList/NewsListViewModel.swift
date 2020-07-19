//
//  NewsListViewModel.swift
//  VideoTracker
//

//  Created by Татьяна Севостьянова on 18.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit

class NewsListViewModel {
    
    var sections: [Int: SectionModel] = [:]
    
    func loadData() {
        
        sections[0] = SectionModel(items: [
            .record(model: Record.init(avatar: .avatar1,
                                       title: "Запись один",
                                       date: "15 мая 2019",
                                       video: .video1,
                                       isLiked: false,
                                       favoriteNumber: 23,
                                       viewsNumber: 123,
                                       isBookmark: false)),
            .record(model: Record.init(avatar: .avatar2,
                                       title: "Запись два",
                                       date: "14 мая 2019",
                                       video: .video2,
                                       isLiked: false,
                                       favoriteNumber: 54,
                                       viewsNumber: 67,
                                       isBookmark: false)),
            .record(model: Record.init(avatar: .avatar3,
                                       title: "Запись три",
                                       date: "13 мая 2019",
                                       video: .video3,
                                       isLiked: false,
                                       favoriteNumber: 200,
                                       viewsNumber: 37,
                                       isBookmark: false)),

        ])
        
    }
}
    


//class NewsListViewModel {
//
//    var news: Variable<[NewsItem]> = .init([])
//
//    private var newsService: NewsService
//
//    init(newsService: NewsService) {
//        self.newsService = newsService
//
//        newsService.getNewsItems { [weak self] result in
//            switch result {
//            case let .success(items):
//                self?.news.value = items
//            case let .failure(error):
//                print("❌ \(error)")
//            }
//        }
//    }
