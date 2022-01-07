//
//  bookAPI.swift
//  InterparkCloneCoding<week5>
//
//  Created by 정지윤 on 2021/12/24.
//

import Foundation

struct BestSellerResponse : Decodable {
    
    var title : String
    var link : String
    var language : String
    var copyright : String
    var pubDate : String
    var imageUrl : String
    var totalResults : Int
    var startIndex : Int
    var itemsPerPage : Int
    var maxResults : Int
    var queryType : String
    var searchCategoryId : String
    var searchCategoryName : String
    var returnCode : String
    var returnMessage : String
    var item : [BestSellerBook]
}

struct BestSellerBook : Decodable {
    var itemId: Int
    var title : String
    var description : String
    var pubDate : String
    var priceStandard : Int
    var priceSales : Int
    var discountRate : String
    var saleStatus : String
    var mileage : String
    var mileageRate : String
    var coverSmallUrl : String
    var coverLargeUrl : String
    var categoryId : String?
    var categoryName: String
    var publisher : String
    var customerReviewRank : Double
    var author : String
    var translator : String
    var isbn : String?
    var link : String
    var mobileLink : String
    var additionalLink : String
    var reviewCount : Int
    var rank : Int
}

