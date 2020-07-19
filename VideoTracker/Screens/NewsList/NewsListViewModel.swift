//
//  NewsListViewModel.swift
//  VideoTracker
//
//  Created by Кирилл Худяков on 18.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import Foundation


class NewsListViewModel {
    
    var news: Variable<[NewsItem]> = .init([])
    
    private var newsService: NewsService
    
    init(newsService: NewsService) {
        self.newsService = newsService
        
        newsService.getNewsItems { [weak self] result in
            switch result {
            case let .success(items):
                self?.news.value = items
            case let .failure(error):
                print("❌ \(error)")
            }
        }
    }
}
