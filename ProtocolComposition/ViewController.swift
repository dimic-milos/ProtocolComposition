//
//  ViewController.swift
//  ProtocolComposition
//
//  Created by Milos Dimic on 1/13/19.
//  Copyright © 2019 Milos Dimic. All rights reserved.
//

import UIKit
class ViewController: UIViewController {}

class ImageProvider {}
class ArticleProvider {}
class PersistanceProvider {}

protocol ImageProvidable {
    var imageProvider: ImageProvider { get }
}

protocol ArticleProvidable {
    var articleProvider: ArticleProvider { get }
}

protocol PersistanceProvidable {
    var persistanceProvider: PersistanceProvider { get }
}


class BasicModel {
    
    typealias Dependencies = ImageProvidable
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

class AdvancedModel {
    
    typealias Dependencies = ImageProvidable & ArticleProvidable & PersistanceProvidable
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}


struct AppDependency: ImageProvidable, ArticleProvidable, PersistanceProvidable {
    
    var imageProvider: ImageProvider
    var articleProvider: ArticleProvider
    var persistanceProvider: PersistanceProvider
}

class AppCoordinator {
    
    let appDependencies = AppDependency(imageProvider: ImageProvider(),
                                        articleProvider: ArticleProvider(),
                                        persistanceProvider: PersistanceProvider())
    
    lazy var basicModel = BasicModel(dependencies: appDependencies)
    lazy var advancedModel = AdvancedModel(dependencies: appDependencies)
}

