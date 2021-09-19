import Foundation
import Alamofire

protocol IMovieListInteractor {
    var numberOfSections: [MovieSection] { get }
    func fetchMovieList()
    func getMoviesCount() -> Int
    func getMoviesViewModel() -> [MovieListModel.ViewModel.Movie]
    func getMoviesEntity() -> [Movie]
    func getNextPage(row: Int)
    func fetchMovieDetail(id: Int)
    func fetchGenreList()
    func getGenreList() -> [Genres]
    func setGenre(genre: Genres)
}

enum MovieSection {
    case genre
    case list
}

class MovieListInteractor: IMovieListInteractor {

    // MARK: Private
    private let service: IMovieService
    private let presenter: IMoviesPresenter
    private var movieRes: [Movie] = []
    private var genreList: [Genres] = []
    private var maxPage: Int?
    private var genre: Int = 12 {
        didSet {
            self.fetchMovieList()
        }
    }
    // MARK: Lifecycle
    
    var numberOfSections: [MovieSection] {
        return [.genre,.list]
    }
    
    init(presenter: IMoviesPresenter, service: IMovieService) {
        self.presenter = presenter
        self.service = service
    }

    // MARK: Internal

    func fetchMovieList() {
        self.presenter.onCallApi()
        service.requestMovieList(request: MoviesRequest.getMovieList(page: 1, genreId: genre)) { results in
            switch results {
            case .success(let movies):
                self.movieRes.removeAll()
                self.maxPage = movies.totalPages
                self.movieRes = movies.results
                self.presenter.presentSuccessGetMovieList()
            case .failure(let error):
                self.presenter.onError(msg: error.localizedDescription)
            }
        }
    }
    
    func fetchMovieDetail(id: Int) {
        self.presenter.onCallApi()
        service.fetchMovieDetail(request: MoviesRequest.getMovieDetail(id: id)) { results in
            switch results {
            case .success(let movies):
                self.presenter.presentSuccessGetMovieDetail(movieDetail: movies)
            case .failure(let error):
                self.presenter.onError(msg: error.localizedDescription)
            }
        }
    }
    
    func fetchGenreList() {
        service.fetchGenreList(request: MoviesRequest.getGenreList) { results in
            switch results {
            case .success(let genre):
                self.genreList = genre.genres
                self.presenter.presentSuccessGetMovieList()
            case .failure(let error):
                self.presenter.onError(msg: error.localizedDescription)
            }
        }
    }
    
    func getMoviesEntity() -> [Movie] {
        return movieRes
    }

    func getMoviesCount() -> Int {
        return movieRes.count
    }
    
    func getGenreList() -> [Genres] {
        return genreList
    }
    
    func setGenre(genre: Genres) {
        self.genre = genre.id
    }
    
    func getMoviesViewModel() -> [MovieListModel.ViewModel.Movie] {
        let movieVM = movieRes.map({
            MovieListModel.ViewModel.Movie(
                title: $0.title,
                date: $0.releaseDate,
                description: $0.overview,
                rating: String($0.voteAverage),
                image: $0.backdropPath)
        })
        return movieVM
    }

    func getNextPage(row: Int) {
        var page: Int = 2
        if row == movieRes.count-1 {
            if let max = maxPage {
                if page < max {
                    service.requestMovieList(request: MoviesRequest.getMovieList(page: page, genreId: genre)) { results in
                        switch results {
                        case .success(let movies):
                            page += 1
                            self.presenter.presentSuccessGetMovieList()
                            self.movieRes.append(contentsOf: movies.results)
                        case .failure(let error):
                            self.presenter.onError(msg: error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}
