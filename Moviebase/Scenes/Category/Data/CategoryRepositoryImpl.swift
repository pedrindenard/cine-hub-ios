//
//  CategoryRepository.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 14/01/25.
//

class CategoryRepositoryImpl: CategoryRepository {
    
    @Injected(\.categoryService) private var service: CategoryService
    
    func getCategories(mediaType: MediaType) async throws -> [Category] {
        let endpoints = self.getEndpoints(for: mediaType)
        
        let results = await self.fetchMediaResults(endpoints: endpoints, mediaType: mediaType)
        let categories = self.createCategories(from: results, mediaType: mediaType)
        
        return categories
    }
    
    private func getEndpoints(for mediaType: MediaType) -> [Endpoint] {
        return mediaType == .movie
        ? [.playingNowMovies, .trendingMovies, .upcomingMovies, .popularMovies, .topRatedMovies]
        : [.airingTodayTvs, .trendingTvs, .onTheAirTvs, .popularTvs, .topRatedTvs]
    }
    
    private func createCategories(from results: [Endpoint: [Media]], mediaType: MediaType) -> [Category] {
        let categories = mediaType == .movie ? CategoryMapper.mapToMovieCategories(results: results) : CategoryMapper.mapToTvCategories(results: results)
        return categories.filter { category in !category.items.isEmpty } // Remove any category that does not have 'items' populated
    }
    
    private func fetchMediaResults(endpoints: [Endpoint], mediaType: MediaType) async -> [Endpoint: [Media]] {
        return await withTaskGroup(of: (Endpoint, [Media]).self) { group in
            for endpoint in endpoints {
                group.addTask {
                    do {
                        let mediaResult = try await self.service.getMedias(endpoint: endpoint, mediaType: mediaType)
                        return (endpoint, try mediaResult.get().results)
                    } catch {
                        return (endpoint, []) // Empty list if failure
                    }
                }
            }
            
            var collectedResults: [(Endpoint, [Media])] = []
            
            for await result in group {
                collectedResults.append(result)
            }
            
            return Dictionary(uniqueKeysWithValues: collectedResults)
        }
    }
    
}
