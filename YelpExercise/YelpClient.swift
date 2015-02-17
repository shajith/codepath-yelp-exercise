//
//  YelpClient.swift
//  YelpExercise
//
//  Created by Shajith on 2/11/15.
//  Copyright (c) 2015 zd. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        var token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, category: String? = nil, deals: Bool? = nil, sort: String? = "0", radius: String? = nil, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        var parameters = ["term": term, "location": "San Francisco"]
        
        if(category != nil) {
            parameters["category_filter"] = category
        }
        
        if(deals != nil) {
            parameters["deals_filter"] = deals! ? "true" : "false"
        }
        
        if(radius != nil) {
            parameters["radius_filter"] = radius
        }
        
        parameters["sort"] = sort
        
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
}