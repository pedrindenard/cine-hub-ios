//
//  GenresProvider.swift
//  Moviebase
//
//  Created by Pedro Denardi Minuzzi on 28/01/25.
//

private struct GenresServiceKey: InjectionKey {
    static var currentValue: GenresService = GenresServiceImpl.init()
}

private struct GenresRepositoryKey: InjectionKey {
    static var currentValue: GenresRepository = GenresRepositoryImpl.init()
}

extension InjectedValues {
    
    var genresService: GenresService {
        get { Self[GenresServiceKey.self] }
        set { Self[GenresServiceKey.self] = newValue }
    }
    
    var genresRepository: GenresRepository {
        get { Self[GenresRepositoryKey.self] }
        set { Self[GenresRepositoryKey.self] = newValue }
    }
    
}
