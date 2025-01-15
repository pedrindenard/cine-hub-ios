//
//  Endpoint.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

enum Endpoint: String {
    
    // MARK: Category endpoints
    case trendingMovies = "trending/movie/day"
    case trendingTvs = "trending/tv/day"
    
    case playingNowMovies = "movie/now_playing"
    case airingTodayTvs = "tv/airing_today"
    
    case topRatedMovies = "movie/top_rated"
    case topRatedTvs = "tv/top_rated"
    
    case upcomingMovies = "movie/upcoming"
    case onTheAirTvs = "tv/on_the_air"
    
    case popularMovies = "movie/popular"
    case popularTvs = "tv/popular"
    
    // MARK: 
}
