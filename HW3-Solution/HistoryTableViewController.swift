//
//  HistoryTableViewController.swift
//  HW3-Solution
//
//  Created by Isfar Baset on 3/28/20.
//  Copyright © 2020 Jonathan Engelsma. All rights reserved.
//

import UIKit

protocol HistoryTableViewControllerDelegate {
    func selectEntry(entry: Conversion)
}

class HistoryTableViewController: UITableViewController {
    
    var entries: [Conversion] = []
    
    var historyDelegate: HistoryTableViewControllerDelegate?
    
 // MARK: - Table view data source
 override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     if let data = self.tableViewData {
         return data.count
     } else {
         return 0
     }
 }
 
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of rows
     if let sectionInfo = self.tableViewData?[section] {
         return sectionInfo.entries.count
     } else {
         return 0
     }
 }

    
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FancyCell", for: indexPath) as! HistoryTableViewCell
        if let entry = self.tableViewData?[indexPath.section].entries[indexPath.row] {
            cell.conversionLabel.text = "\(entry.fromVal) \(entry.fromUnits) = \(entry.toVal) \(entry.toUnits)"
            cell.timestampLabel.text = "\(entry.timestamp.description)"
            cell.thumbnail.image = UIImage(imageLiteralResourceName: entry.mode == .Volume ? "volume" : "length")
        }
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) ->
        String? {
            return self.tableViewData?[section].sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
        CGFloat {
            return 80.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection
        section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = BACKGROUND_COLOR
        header.contentView.backgroundColor = FOREGROUND_COLOR
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView,
                            forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = BACKGROUND_COLOR
        header.contentView.backgroundColor = FOREGROUND_COLOR
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let del = self.historyDelegate {
            if let conv = self.tableViewData?[indexPath.section].entries[indexPath.row] {
                del.selectEntry(entry: conv)
            }
        }
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
    self.sortIntoSections(entries: self.entries )
    }
    
    var tableViewData: [(sectionHeader: String, entries: [Conversion])]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func sortIntoSections(entries: [Conversion]) {
        
        var tmpEntries : Dictionary<String,[Conversion]> = [:]
        var tmpData: [(sectionHeader: String, entries: [Conversion])] = []
        
        for entry in entries {
            
            let shortDate = entry.timestamp.short
            if var bucket = tmpEntries[shortDate] {
                bucket.append(entry)
                tmpEntries[shortDate] = bucket
            } else {
                tmpEntries[shortDate] = [entry]
            }
        }

        let keys = tmpEntries.keys
        for key in keys {
            if let val = tmpEntries[key] {
                tmpData.append((sectionHeader: key, entries: val))
            }
        }
        
        tmpData.sort { (v1, v2) -> Bool in
            if v1.sectionHeader < v2.sectionHeader {
                return true
            } else {
                return false
            }
        }
        
        self.tableViewData = tmpData
    }

    
    
}

extension Double {

    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

