//
//  ViewController.swift
//  YelpExercise
//
//  Created by Shajith on 2/9/15.
//  Copyright (c) 2015 zd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FilterChangeDelegate {

    @IBOutlet weak var restaurantsTable: UITableView!
    @IBOutlet weak var restaurantSearchBar: UISearchBar!
    
    var yelpClient: YelpClient = YelpClient(consumerKey: "qQnCDr5ChYSaUaKreXlYMA", consumerSecret: "vdFdTl9rqMbfIRORygXvbkHkZrQ", accessToken: "sZkoEKZYOTWRv6aYaO-CrG4pD48avSmB", accessSecret: "cSZenCW5-d7XmpVskrH50iJRNVg")
    
    var restaurants: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        restaurantSearchBar.delegate = self
        navigationItem.titleView = restaurantSearchBar
        
        restaurantsTable.delegate = self
        restaurantsTable.dataSource = self
        restaurantsTable.rowHeight = UITableViewAutomaticDimension
        restaurantsTable.estimatedRowHeight = 50.0
        
        performSearch("ramen")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell1") as RestaurantCell
        
        var restaurant = restaurants[indexPath.row] as NSDictionary
        
        cell.thumbImage.setImageWithURL(NSURL(string: restaurant["image_url"] as String))
        //cell.ratingImage.setImageWithURL(NSURL(string: restaurant["rating_img_url"] as String))
        
        cell.nameLabel.text = restaurant["name"] as String!
        var displayAddress = (restaurant.valueForKeyPath("location.display_address") as NSArray!)

        var address = "\(displayAddress[0])"
        if(displayAddress.count > 1) {
            address = address + ", "
            address = address + (displayAddress[1] as String)
        }
        
        cell.addressLabel.text = address
        

        var reviewCount = restaurant["review_count"] as Int!
        
        var rating = restaurant["rating"] as Float
        
        var formatter = NSNumberFormatter()
        
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        var formattedReviewCount = formatter.stringFromNumber(reviewCount)!
        
        cell.reviewsLabel.text = "\(formatRating(rating)) from \(formattedReviewCount) reviews"
        
        cell.distanceLabel.text = restaurant["distance"] as String!
        
        return cell
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        performSearch(searchBar.text)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as FiltersTableViewController
        vc.delegate = self
    }
    
    func performSearch(query: String, category: String? = nil, deals: Bool? = nil, sort: String? = "0", radius: String? = nil) {
        JHProgressHUD.sharedHUD.showInView(view, withHeader: "Loading", andFooter: "")
        
        JHProgressHUD.sharedHUD.showInView(view)
        
        func success(operation: AFHTTPRequestOperation!, result: AnyObject!) {
            println(result)
            
            self.restaurants = result["businesses"] as NSArray
            self.restaurantsTable.reloadData()
            JHProgressHUD.sharedHUD.hide()
        }
        
        yelpClient.searchWithTerm(query, category: category, success: success, failure: success)
    }
    
    func filtersChanged(filters: Array<Filter>) {
        
        var category = filters.filter({$0.name == "category"})[0];
        var selectedCategories = category.options.filter({$0.selected}).map({$0.value})
        var categoryParam = ",".join(selectedCategories)
        
        var radius = filters.filter({$0.name == "radius"})[0];
        var selectedRadiusOptions = radius.options.filter({$0.selected})
        var radiusParam : String? = selectedRadiusOptions.count > 0 ? selectedRadiusOptions[0].value : nil

        var sort = filters.filter({$0.name == "sort"})[0]
        var sortParam = sort.options.filter({$0.selected})[0].value

        var deals = filters.filter({$0.name == "deals"})[0]
        var dealsParam = deals.options.filter({$0.selected}).count > 0
        
        performSearch(restaurantSearchBar.text, category: categoryParam, radius: radiusParam, sort: sortParam, deals: dealsParam)
        
        
    }
    
    func formatRating(rating: Float) -> String {
        
        var res : String = "";
        if(rating - floor(rating) == 0.5) {
            for index in 1...(Int(rating)) {
                res = res + "★"
            }
            
            res = res + "½"
        } else {
            for index in 1...(Int(rating)) {
                res = res + "★"
            }
        }
        
        return res
    }

}

