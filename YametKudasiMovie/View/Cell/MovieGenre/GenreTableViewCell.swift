//
//  GenreTableViewCell.swift
//  YametKudasiMovie
//
//  Created by AkbarPuteraW on 19/09/21.
//

import UIKit
protocol GenreProtocol {
    func didSelectedItem(genre: Genres)
}
class GenreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var genreCollection: UICollectionView!
    
    var delegate: GenreProtocol?
    
    private var list: [Genres] = [] {
        didSet {
            self.genreCollection.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        genreCollection.register(UINib(nibName: String(describing: GenreCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "cellid")
        self.genreCollection.dataSource = self
        self.genreCollection.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func initView(genre: [Genres]) {
        self.list = genre
    }
    
}

extension GenreTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = genreCollection.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! GenreCollectionViewCell
        cell.titleLabel.text = list[indexPath.row].name
        return cell
    }
}


extension GenreTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectedItem(genre: list[indexPath.row])
    }
}
