//
//  bestSellerRequest.swift
//  InterparkCloneCoding<week5>
//
//  Created by 정지윤 on 2021/12/28.
//

import Foundation
import Alamofire

class bestSellerRequest {
    
    func getBestSeller(_ viewController: BestSellerViewController) {
    
        let url = "http://book.interpark.com/api/bestSeller.api"
    
        let params : Parameters = [
        
            "key" : "DE3506F7A70552116B5E5862640F70DE44CA723ABF7F29EC312FFBAFFDE3C6F8",
            "categoryId" : "100",
            "output" : "json"
        
        ]
        
        //HTTP Method: GET
        AF.request(url,
                   method: .get,
                   parameters: params,
                   headers: nil)
            .responseDecodable(of: BestSellerResponse.self) { response in
                
                switch response.result {
                
                case .success(let response):
                    print("DEBUG>> Interpark Response \(response) ")
                    viewController.didSuccess(response)
                    
                case .failure(let error):
                    print("DEBUG>> Interpark Get Error : \(error)")
                    
                }
            }
        
        
    }
    
}
