//
//  CategoryRepositoryProviderKey.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 15/01/25.
//

private struct CategoryServiceProviderKey: InjectionKey {
    static var currentValue: CategoryService = CategoryServiceImpl()
}

private struct CategoryRepositoryProviderKey: InjectionKey {
    static var currentValue: CategoryRepository = CategoryRepositoryImpl()
}

private struct CategoryRouterProviderKey: InjectionKey {
    static var currentValue: CategoryViewRouter = CategoryViewRouter()
}

extension InjectedValues {
    
    var categoryServiceProvider: CategoryService {
        get { Self[CategoryServiceProviderKey.self] }
        set { Self[CategoryServiceProviderKey.self] = newValue }
    }
    
    var categoryRepositoryProvider: CategoryRepository {
        get { Self[CategoryRepositoryProviderKey.self] }
        set { Self[CategoryRepositoryProviderKey.self] = newValue }
    }
    
    var categoryRouterProvider: CategoryViewRouter {
        get { Self[CategoryRouterProviderKey.self] }
        set { Self[CategoryRouterProviderKey.self] = newValue }
    }
    
}
