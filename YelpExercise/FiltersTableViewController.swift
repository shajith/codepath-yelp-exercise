//
//  FiltersTableViewController.swift
//  YelpExercise
//
//  Created by Shajith on 2/9/15.
//  Copyright (c) 2015 zd. All rights reserved.
//

import UIKit

protocol FilterChangeDelegate : class {
    func filtersChanged(filters: Array<Filter>)
}

class FiltersTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var filtersTable: UITableView!
    
    weak var delegate : FilterChangeDelegate?;
    
    var filters: Array<Filter> = [
        Filter(
            label: "Sort", name: "sort", options: [
                FilterOption(label: "Best match", value: "0", selected: true),
                FilterOption(label: "Distance", value: "1"),
                FilterOption(label: "Highest rated", value: "2"),
            ],
            type: FilterType.Single),
        
        Filter(
            label: "Radius", name: "radius", options: [
                FilterOption(label: "0.3 miles", value: "482"),
                FilterOption(label: "1 mile", value: "1609"),
                FilterOption(label: "5 miles", value: "8047"),
            ],
            type: FilterType.Single),
        
        Filter(label: "Deals", name: "deals", options: [
                FilterOption(label: "Has deals", value: "deals")
            ], type: FilterType.Boolean),
        
        Filter(label: "Category", name: "category", options: [
            FilterOption(label: "Arabian", value: "arabian"),
            FilterOption(label: "Argentine", value: "argentine"),
            FilterOption(label: "Breakfast & Brunch", value: "breakfast_brunch"),
            FilterOption(label: "Burgers ", value: "burgers"),
            FilterOption(label: "Cafes ", value: "cafes"),
            FilterOption(label: "Chinese ", value: "chinese"),
            FilterOption(label: "Cuban ", value: "cuban"),
            FilterOption(label: "French ", value: "french"),
            FilterOption(label: "German ", value: "german"),
            FilterOption(label: "Greek ", value: "greek"),
            FilterOption(label: "Hawaiian ", value: "hawaiian"),
            FilterOption(label: "Indian ", value: "indpak"),
            FilterOption(label: "Irish ", value: "irish"),
            FilterOption(label: "Italian ", value: "italian"),
            FilterOption(label: "Japanese ", value: "japanese"),
            FilterOption(label: "Mediterranean ", value: "mediterranean"),
            FilterOption(label: "Mexican ", value: "mexican"),
            FilterOption(label: "Peruvian ", value: "peruvian"),
            FilterOption(label: "Pizza ", value: "pizza"),
            FilterOption(label: "Seafood ", value: "seafood"),
            FilterOption(label: "Spanish ", value: "spanish"),
            FilterOption(label: "Sushi Bars ", value: "sushi"),
            FilterOption(label: "Thai ", value: "thai")
        ], type: FilterType.Multiple)
    ];
    
/*
,

*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filtersTable.delegate = self
        filtersTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters[section].options.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return  filters.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filters[section].label
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("FilterCell") as FilterCell
        
        cell.optionNameLabel.text = filters[indexPath.section].options[indexPath.row].label
        cell.optionValueSwitch.on = filters[indexPath.section].options[indexPath.row].selected
        return cell
        
    }
    
    @IBAction func optionChanged(sender: AnyObject) {
        let switchView = (sender as UISwitch)
        let cell = switchView.superview?.superview as UITableViewCell
        
        if let indexPath = filtersTable.indexPathForCell(cell) {
            var filter = filters[indexPath.section]
            
            if(filter.type == FilterType.Single) {
                for option in filter.options {
                    option.selected = false
                }
            }
            
            filter.options[indexPath.row].selected = switchView.on
            
            filtersTable.reloadData()
        }
    }
    
    @IBAction func didSearch(sender: AnyObject) {
        delegate?.filtersChanged(filters)
        dismissViewControllerAnimated(true, completion: nil)
    }
}
