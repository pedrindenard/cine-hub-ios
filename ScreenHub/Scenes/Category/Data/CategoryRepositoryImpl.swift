//
//  CategoryRepository.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Combine

class CategoryRepositoryImpl: CategoryRepository {
    
    @Injected(\.categoryServiceProvider) private var service: CategoryService
    
    func getCategories(mediaType: MediaType) -> AnyPublisher<[Category], NetworkError> {
        let endpoints: [Endpoint] = mediaType == .movie ? [
            .trendingMovies, .popularMovies, .playingNowMovies, .topRatedMovies, .upcomingMovies
        ] : [
            .trendingTvs, .popularTvs, .airingTodayTvs, .topRatedTvs, .onTheAirTvs
        ]
        
        let publishers: [AnyPublisher<[Media], NetworkError>] = endpoints.map { endpoint in
            service.getMedias(endpoint: endpoint, mediaType: mediaType)
                .map { response in CategoryMapper.map(response: response) }
                .eraseToAnyPublisher()
        }
        
        return Publishers.Zip(publishers[0], publishers[1]).flatMap { trending, popular in
            Publishers.Zip(publishers[2], publishers[3]).flatMap { playingNow, topRated in
                publishers[4].map { upcoming in
                    return mediaType == .movie ? [
                        Category(name: "Movie Trending", items: trending.shuffled(), type: .banner),
                        Category(name: "Movie Popular", items: popular.shuffled(), type: .carrousel),
                        Category(name: "Movie Playing Now", items: playingNow.shuffled(), type: .carrousel),
                        Category(name: "Movie Top Rated", items: topRated.shuffled(), type: .carrousel),
                        Category(name: "Movie Upcoming", items: upcoming.shuffled(), type: .carrousel)
                    ] : [
                        Category(name: "TV Trending", items: trending.shuffled(), type: .banner),
                        Category(name: "TV Popular", items: popular.shuffled(), type: .carrousel),
                        Category(name: "TV Airing Today", items: playingNow.shuffled(), type: .carrousel),
                        Category(name: "TV Top Rated", items: topRated.shuffled(), type: .carrousel),
                        Category(name: "Tv On Air", items: upcoming.shuffled(), type: .carrousel)
                    ]
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
