//
//  BoxOfficeDataManager.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import Alamofire

class BookDataManager {
    func searchBestSellerBooks(categoryId: String, urlType: String, delegate: BestSellerViewController) {
        let url = "\(Constant.BOOK_BASE_URL)"
            + "\(urlType).api"
            + "?key=\(KobisKey.BOOK_API_KEY)"
            + "&categoryId=\(categoryId)&output=json"
        
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: BestSellerResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didRetrieveBooks(result: response.item)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func searchRecommendBooks(categoryId: String, urlType: String, delegate: RecommendViewController) {
        let url = "\(Constant.BOOK_BASE_URL)"
            + "\(urlType).api"
            + "?key=\(KobisKey.BOOK_API_KEY)"
            + "&categoryId=\(categoryId)&output=json"
        
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: RecommendResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didRetrieveBooks(result: response.item)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func searchNewBooks(categoryId: String, urlType: String, delegate: BookMainViewController) {
        let url = "\(Constant.BOOK_BASE_URL)"
            + "\(urlType).api"
            + "?key=\(KobisKey.BOOK_API_KEY)"
            + "&categoryId=\(categoryId)&output=json"
        
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: RecommendResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didRetrieveBooks(result: response.item)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }

}
