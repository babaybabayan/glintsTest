import Foundation

protocol IMovieDetailPresenter: BaseProtocol {
    func presentMovieDetail(response: MovieDetailModel.Response)
    func handleTap(address: String)
}

class MovieDetailPresenter: IMovieDetailPresenter {
    
    private var view: IMovieDetailViewController?
    
    init(view: IMovieDetailViewController) {
        self.view = view
    }
    
    func presentMovieDetail(response: MovieDetailModel.Response) {
        view?.displayMovieDetail(
            viewModel: MovieDetailModel.ViewModel(
                title: response.movie.title ?? "",
                subTitle: String(response.movie.tagline ?? ""),
                rating: String(response.movie.voteAverage ?? 0.0),
                genre: response.movie.genres!.map({$0.name}).joined(separator: ", "),
                description: response.movie.overview ?? "",
                image: response.movie.backdropPath ?? ""))
    }
    
    func handleTap(address: String) {
        view?.playTrailer(address: address)
    }
    
    func onCallApi() {
        
    }
    
    func onSuccess() {
        
    }
    
    func onError(msg: String) {
        
    }
}
