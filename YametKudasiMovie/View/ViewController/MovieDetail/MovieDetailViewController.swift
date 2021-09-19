import UIKit
import Kingfisher

protocol IMovieDetailViewController: BaseProtocol {
    func displayMovieDetail(viewModel: MovieDetailModel.ViewModel)
    func playTrailer(address: String)
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet var ratings: [UIImageView]!
    
    private var interactor: IMovieDetailInteractor!
    
    convenience init(movie: MovieDetail) {
        let bundle = Bundle(for: type(of: self))
        self.init(nibName: "MovieDetailViewController", bundle: bundle)
        setup(movie: movie)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAppreance()
        interactor.handleMovieDetail()
    }
    
    private func setup(movie: MovieDetail) {
        let presenter = MovieDetailPresenter(view: self)
        interactor = MovieDetailInteractor(presenter: presenter, movie: movie)
    }
    
    private func setAppreance() {
        self.imageTitle.contentMode = .scaleAspectFill
        self.titleLabel.numberOfLines = 0
        self.aboutLbl.numberOfLines = 0
    }
    
    private func initView(movie: MovieDetailModel.ViewModel) {
        self.titleLabel.text = movie.title
        self.subTitle.text =  movie.subTitle
        self.ratingLabel.text = movie.rating
        self.genreLbl.text = movie.genre
        self.descLabel.text = movie.description
        self.imageTitle.kf.setImage(with: URL(string: Constant.Endpoint.BASE_URL_IMG + movie.image))
        for i in 0...movie.rating.roundedStr() {
            ratings[i].image = UIImage(named: "Star Fill")
        }
        ratingLabel.textColor = Ratings.ratingScore(rating: Float(movie.rating) ?? 0.0).desc
    }
    
    @IBAction func trailerBtnTapped(_ sender: UIButton) {
        interactor.handlePlay()
    }
    
}

extension MovieDetailViewController: IMovieDetailViewController {
    func onCallApi() {
        
    }
    
    func onSuccess() {
        
    }
    
    func onError(msg: String) {
        
    }
    
    func displayMovieDetail(viewModel: MovieDetailModel.ViewModel) {
        initView(movie: viewModel)
    }
    
    func playTrailer(address: String) {
        if let url = URL(string: address) {
            UIApplication.shared.open(url)
        }
    }
}
