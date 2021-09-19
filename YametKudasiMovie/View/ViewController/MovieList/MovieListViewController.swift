import UIKit

protocol IMoviesViewController: AnyObject {
    func displaySuccesGetMoviesList()
    func onCallApi()
    func onError(msg: String)
    func presentToDetail(movieDetail: MovieDetail)
}

class MovieListViewController: UIViewController {

    // MARK: Private
    private var interactor: IMovieListInteractor?
    private var route: PresenterToRouterProtocol?
    private let refreshControll = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Yamet Kudasi Movies"
        setup()
        fetchMovie()
    }

    private func setup() {
        let presenter = MoviesListPresenter(view: self)
        interactor = MovieListInteractor(presenter: presenter, service: MovieService())
        route = MovieRouter()
        MovieListTableViewCell.registerTo(tableView: tableView)
        GenreTableViewCell.registerTo(tableView: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControll
        refreshControll.addTarget(self, action: #selector(doRefresh(_:)), for: .valueChanged)
    }
    
    private func fetchMovie() {
        interactor?.fetchGenreList()
        interactor?.fetchMovieList()
    }
    
    @objc private func doRefresh(_ sender: UIRefreshControl) {
        interactor?.fetchMovieList()
    }
    
    private func removeObser() {
        ProgressHUD.dismiss()
        self.refreshControll.endRefreshing()
    }
}

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor?.numberOfSections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch interactor?.numberOfSections[section] {
        case .genre:
            return 1
        case .list:
            return interactor?.getMoviesCount() ?? 0
        case .none:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch interactor?.numberOfSections[indexPath.section] {
        case .genre:
            let cell = GenreTableViewCell.dequeue(tableView: tableView, indexPath: indexPath)
            cell.initView(genre: interactor?.getGenreList() ?? [])
            cell.delegate = self
            return cell
        case .list:
            let movies = interactor?.getMoviesViewModel()[indexPath.row]
            if let movie = movies {
                let cell = MovieListTableViewCell.dequeue(tableView: tableView, indexPath: indexPath)
                cell.initData(param: movie)
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedMovie = interactor?.getMoviesEntity()[indexPath.row] else { return }
        interactor?.fetchMovieDetail(id: selectedMovie.id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        interactor?.getNextPage(row: indexPath.row)
    }
}

// MARK: - IMoviesPresenter

extension MovieListViewController: IMoviesViewController {
    func onCallApi() {
        ProgressHUD.show("Loading")
    }
    
    func displaySuccesGetMoviesList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.removeObser()
        }
    }
    
    func onError(msg: String) {
        DispatchQueue.main.async {
            AlertUtils.showCustomAlert(self, title: "", message: msg)
            self.removeObser()
        }
    }
    
    func presentToDetail(movieDetail: MovieDetail) {
        self.removeObser()
        route?.pushToDetailMovieScreen(movie: movieDetail, navigationConroller: self.navigationController!)
    }
}

extension MovieListViewController: GenreProtocol {
    func didSelectedItem(genre: Genres) {
        self.title = genre.name
        interactor?.setGenre(genre: genre)
    }
    
    
}
