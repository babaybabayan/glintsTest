import Foundation

protocol BaseProtocol {
    func onCallApi()
    func onSuccess()
    func onError(msg: String)
}

protocol IMovieDetailInteractor: AnyObject {
    func handleMovieDetail()
    func handlePlay()
}

class MovieDetailInteractor: IMovieDetailInteractor {
    
    private var presenter: IMovieDetailPresenter?
    private var movie: MovieDetail
    private let service: IMovieService
    
    init(presenter: IMovieDetailPresenter, movie: MovieDetail) {
        self.presenter = presenter
        self.movie = movie
        self.service = MovieService()
    }
    
    func handleMovieDetail() {
        self.presenter?.presentMovieDetail(response: MovieDetailModel.Response(movie: movie))

    }
    
    func handlePlay() {
        presenter?.handleTap(address: Constant.Endpoint.YOUTUBE_DEEPLINK + (movie.videos?.results?.first?.key ?? ""))
    }
}
