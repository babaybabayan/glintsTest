protocol PresenterToRouterProtocol {
    static func createModule(movie: MovieDetail) -> MovieDetailViewController
    func pushToDetailMovieScreen(movie: MovieDetail, navigationConroller:UINavigationController)
}

import UIKit

class MovieRouter: PresenterToRouterProtocol {
    
    static func createModule(movie: MovieDetail) -> MovieDetailViewController {
        let controller = MovieDetailViewController(movie: movie)
        return controller
    }
    
    func pushToDetailMovieScreen(movie: MovieDetail, navigationConroller: UINavigationController) {
        let module = MovieRouter.createModule(movie: movie)
        navigationConroller.pushViewController(module, animated: true)
    }
    
}
