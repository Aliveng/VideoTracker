//
//  NewsListViewModel.swift
//  VideoTracker
//

//  Created by Татьяна Севостьянова on 18.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit


class NewsListViewModel {

    var news: Variable<[NewsItem]> = .init([])

    private var newsService: NewsService

    init(newsService: NewsService) {
        self.newsService = newsService

    }
    
    func loadData() {
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
