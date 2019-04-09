//
//  EntryListTableViewController.swift
//  JournalCloud2
//
//  Created by Colin Smith on 4/8/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateViews()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func updateViews(){
        EntryController.shared.fetchEntries { (entries) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.shared.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry = EntryController.shared.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let detailViewController = segue.destination as? EntryViewController,
                let selectedRow = tableView.indexPathForSelectedRow?.row {
                let entry = EntryController.shared.entries[selectedRow]
                    detailViewController.entry = entry
            }
        }
    }
}
