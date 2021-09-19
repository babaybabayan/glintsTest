
import Foundation
import Alamofire
import SwiftyJSON

typealias Result<T> = Swift.Result<T, Error>

class BaseAPIService {
    func request<T>(request: URLRequestConvertible, completionHandler: @escaping (Result<ApiResponse<T>>) -> Void) {
        AF.request(request).responseData { (response) in
            
            guard let httpUrlResponse = response.response else {
                completionHandler(.failure(NetworkRequestError(error: response.error)))
                return
            }
            
            let successRange = 200...299
            if successRange.contains(httpUrlResponse.statusCode) {
                do {
                    let response = try ApiResponse<T>(data: response.data, httpUrlResponse: httpUrlResponse)
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(error))
                }
            } else {
                completionHandler(.failure(ApiError(data: response.data, httpUrlResponse: httpUrlResponse)))
            }
        }
    }
}

