//
//  MovieListTableViewCell.swift
//  SBTest
//
//  Created by Stockbit on 06/08/21.
//

import UIKit
import Kingfisher

final class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet var ratings: [UIImageView]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageTitle.contentMode = .scaleAspectFill
        self.titleLbl.numberOfLines = 0
    }
    
    func initData(param movie : MovieListModel.ViewModel.Movie) {
        self.titleLbl.text = movie.title
        self.dateLbl.text = movie.date
        self.descLbl.text = movie.description
        self.scoreLbl.text = movie.rating
        self.imageTitle.kf.setImage(with: URL(string: Constant.Endpoint.BASE_URL_IMG + movie.image))

        let size = movie.rating.roundedStr()
        for i in 0..<ratings.count {
            ratings[i].image = i > size ? UIImage(named: "Star Empty") : UIImage(named: "Star Fill")
        }
        scoreLbl.textColor = Ratings.ratingScore(rating: Float(movie.rating) ?? 0.0).desc
    }
}

extension String {
    func roundedStr() -> Int {
        return Int(floor((Float(self) ?? 0.0)*5)/10)
    }
}
