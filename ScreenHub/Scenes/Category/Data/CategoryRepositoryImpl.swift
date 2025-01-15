//
//  CategoryRepository.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

import Combine

class CategoryRepositoryImpl: CategoryRepository {
    
    @Injected(\.categoryServiceProvider) private var service: CategoryService
    
    func getCategories(type: CategoryType) -> AnyPublisher<[Category], NetworkError> {
        let endpoints: [Endpoint] = [
            .trendingMovies, .popularMovies, .playingNowMovies, .topRatedMovies, .upcomingMovies,
            .trendingTvs, .popularTvs, .airingTodayTvs, .topRatedTvs, .onTheAirTvs
        ]
        
        let publishers: [AnyPublisher<[CategoryItem], NetworkError>] = endpoints.map { endpoint in
            service.getMedias(endpoint: endpoint)
                .map { response in self.map(response) }
                .eraseToAnyPublisher()
        }
        
        let categories = Publishers.Zip(publishers[0], publishers[1]).flatMap { trending, popular in
            
            Publishers.Zip(publishers[2], publishers[3]).flatMap { playingNow, topRated in
                
                Publishers.Zip(publishers[4], publishers[5]).flatMap { upcoming, newRelease in
                    
                    Publishers.Zip(publishers[6], publishers[7]).flatMap { highlyRated, documentaries in
                        
                        Publishers.Zip(publishers[8], publishers[9]).map { classics, tvOnAir in
                            return [
                                // Movies
                                Category(name: "Movie Trending", items: trending, type: .movie),
                                Category(name: "Movie Popular", items: popular, type: .movie),
                                Category(name: "Movie Playing Now", items: playingNow, type: .movie),
                                Category(name: "Movie Top Rated", items: topRated, type: .movie),
                                Category(name: "Movie Upcoming", items: upcoming, type: .movie),
                                // TV Shows
                                Category(name: "Tv Trending", items: trending, type: .tv),
                                Category(name: "Tv Popular", items: popular, type: .tv),
                                Category(name: "Tv Airing Today", items: playingNow, type: .tv),
                                Category(name: "Tv Top Rated", items: topRated, type: .tv),
                                Category(name: "Tv On Air", items: tvOnAir, type: .tv)
                            ]
                        }
                    }
                }
            }
        }
        
        return categories.eraseToAnyPublisher()
    }
    
    private func map(_ response: MediaResult) -> [CategoryItem] {
        response.results.map { media in
            CategoryItem(name: media.name, imagePath: media.poster)
        }
    }
    
}
