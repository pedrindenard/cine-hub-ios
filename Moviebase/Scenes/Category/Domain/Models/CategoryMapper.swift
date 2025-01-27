//
//  Category.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

struct CategoryMapper {
    
    static func mapToMovieCategories(results: [Endpoint: [Media]]) -> [Category] {
        [
            Category(
                name: LocalizedString.categoryPlayingNow,
                items: results[.playingNowMovies].orEmpty().shuffled(),
                endpoint: .playingNowMovies
            ),
            Category(
                name: LocalizedString.categoryTrending,
                items: results[.trendingMovies].orEmpty().shuffled(),
                endpoint: .trendingMovies
            ),
            Category(
                name: LocalizedString.categoryUpcoming,
                items: results[.upcomingMovies].orEmpty().shuffled(),
                endpoint: .upcomingMovies
            ),
            Category(
                name: LocalizedString.categoryPopular,
                items: results[.popularMovies].orEmpty().shuffled(),
                endpoint: .popularMovies
            ),
            Category(
                name: LocalizedString.categoryTopRated,
                items: results[.topRatedMovies].orEmpty().shuffled(),
                endpoint: .topRatedMovies
            )
        ]
    }
    
    static func mapToTvCategories(results: [Endpoint: [Media]]) -> [Category] {
        [
            Category(
                name: LocalizedString.categoryAiringToday,
                items: results[.airingTodayTvs].orEmpty().shuffled(),
                endpoint: .airingTodayTvs
            ),
            Category(
                name: LocalizedString.categoryTrending,
                items: results[.trendingTvs].orEmpty().shuffled(),
                endpoint: .trendingTvs
            ),
            Category(
                name: LocalizedString.categoryOnAir,
                items: results[.onTheAirTvs].orEmpty().shuffled(),
                endpoint: .onTheAirTvs
            ),
            Category(
                name: LocalizedString.categoryPopular,
                items: results[.popularTvs].orEmpty().shuffled(),
                endpoint: .popularTvs
            ),
            Category(
                name: LocalizedString.categoryTopRated,
                items: results[.topRatedTvs].orEmpty().shuffled(),
                endpoint: .topRatedTvs
            )
        ]
    }
    
    static func map(response: MediaResult) -> [Media] {
        response.results
    }
}
