import Foundation
import Alamofire

protocol IMovieService {
    func requestMovieList(request: URLRequestConvertible, completion: @escaping (_ movies: Result<MovieList>) -> Void)
    func fetchMovieDetail(request: URLRequestConvertible, completion: @escaping (_ movies: Result<MovieDetail>) -> Void)
    func fetchGenreList(request: URLRequestConvertible, completion: @escaping (_ movies: Result<GenreList>) -> Void)
}

struct MovieService: IMovieService {
    
    private var api: BaseAPIService = BaseAPIService()
    
    func requestMovieList(request: URLRequestConvertible, completion: @escaping (Result<MovieList>) -> Void) {
        api.request(request: request) { (result: Result<ApiResponse<MovieList>>) in
            switch result {
            case .success(let response):
                completion(.success(response.entity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetail(request: URLRequestConvertible, completion: @escaping (Result<MovieDetail>) -> Void) {
        api.request(request: request) { (result: Result<ApiResponse<MovieDetail>>) in
            switch result {
            case .success(let response):
                completion(.success(response.entity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchGenreList(request: URLRequestConvertible, completion: @escaping (Result<GenreList>) -> Void) {
        api.request(request: request) { (result: Result<ApiResponse<GenreList>>) in
            switch result {
            case .success(let response):
                completion(.success(response.entity))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    

}
