import Foundation

struct MovieDetailModel {
    struct Response {
        var movie: MovieDetail
    }
    
    struct ViewModel {
        var title: String
        var subTitle: String
        var rating: String
        var genre: String
        var description: String
        var image: String
    }
}
