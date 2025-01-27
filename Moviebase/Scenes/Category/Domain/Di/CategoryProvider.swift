//
//  CategoryRepositoryProviderKey.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

private struct CategoryServiceKey: InjectionKey {
    static var currentValue: CategoryService = CategoryServiceImpl.init()
}

private struct CategoryRepositoryKey: InjectionKey {
    static var currentValue: CategoryRepository = CategoryRepositoryImpl.init()
}

extension InjectedValues {
    
    var categoryService: CategoryService {
        get { Self[CategoryServiceKey.self] }
        set { Self[CategoryServiceKey.self] = newValue }
    }
    
    var categoryRepository: CategoryRepository {
        get { Self[CategoryRepositoryKey.self] }
        set { Self[CategoryRepositoryKey.self] = newValue }
    }
    
}
