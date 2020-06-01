//
//  StatisticsViewController.swift
//  Movies
//
//  Created by Fitore Gashi on 6/1/20.
//  Copyright © 2020 Fitore Gashi. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    var movies = [Movie]()
    var releaseYears = [String]()
    var years = [String]()
    var valueForYear = [Int]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Movies/Year"
        
        releaseYears = [String]()
        for movie in movies {
            releaseYears.append(movie.releaseYear)
        }
        
        let grouped = Dictionary(grouping: releaseYears, by: { $0 }).mapValues { items in items.count }
        for (key, value) in grouped {
            print("\(key) -> \(value)")
            years.append(key)
            valueForYear.append(value)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: UITableViewDelegate
extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return years.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath)
        cell.textLabel?.text = "Year: \(years[indexPath.row]) Movies: \(valueForYear[indexPath.row])"
        return cell
    }
}
