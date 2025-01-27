//
//  Endpoint.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

enum Endpoint: String {
    
    case trendingMovies = "trending/movie/day"
    case playingNowMovies = "movie/now_playing"
    case topRatedMovies = "movie/top_rated"
    case upcomingMovies = "movie/upcoming"
    case popularMovies = "movie/popular"
    
    case trendingTvs = "trending/tv/day"
    case airingTodayTvs = "tv/airing_today"
    case topRatedTvs = "tv/top_rated"
    case onTheAirTvs = "tv/on_the_air"
    case popularTvs = "tv/popular"
    
    case searchPerson = "search/person"
    case searchMovie = "search/movie"
    case searchMulti = "search/multi"
    case searchTv = "search/tv"

}
