import Foundation

protocol IMoviesPresenter {
    func presentSuccessGetMovieList()
    func presentSuccessGetMovieDetail(movieDetail: MovieDetail)
    func onCallApi()
    func onError(msg: String)
}

class MoviesListPresenter: IMoviesPresenter {
    
    
    // MARK: Private
    private weak var view: IMoviesViewController?
    
    init(view: IMoviesViewController) {
        self.view = view
    }

    // MARK: Internal

    func presentSuccessGetMovieList() {
        view?.displaySuccesGetMoviesList()
    }
    
    func presentSuccessGetMovieDetail(movieDetail: MovieDetail) {
        view?.presentToDetail(movieDetail: movieDetail)
    }
    
    func onCallApi() {
        view?.onCallApi()
    }
    
    func onError(msg: String) {
        view?.onError(msg: msg)
    }

}
