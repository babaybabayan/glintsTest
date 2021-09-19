//
//  MovieRequest.swift
//  YametKudasiMovie
//
//  Created by AkbarPuteraW on 19/09/21.
//

import Foundation
import Alamofire

enum MoviesRequest: URLRequestConvertible {
    
    case getMovieList(page: Int, genreId: Int)
    case getMovieDetail(id: Int)
    case getGenreList
    
    var path: String {
        switch self {
        case .getMovieList:
            return "movie/popular"
        case .getMovieDetail(let id):
            return "movie/\(id)"
        case .getGenreList:
            return "genre/movie/list"
        }
    }

    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var parameter: [String: AnyObject] {
        switch self {
        case .getMovieList(let page, let genre):
            return [
                "api_key": Constant.APIkey.API_KEY as AnyObject,
                "page": page as AnyObject,
                "with_genres" : genre as AnyObject
            ]
        case .getMovieDetail:
            return [
                "api_key": Constant.APIkey.API_KEY as AnyObject,
                "append_to_response": "videos" as AnyObject,
                "language" : "en-US" as AnyObject
            ]
        default:
            return ["api_key": Constant.APIkey.API_KEY as AnyObject]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constant.Endpoint.BASE_URL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return try URLEncoding.default.encode(urlRequest, with: self.parameter)
    }
}
