//
//  HistoryTableViewController.swift
//  BookOrder
//
//  Created by xy Man on 2022/5/3.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    let dbtools=DBtools()
    var hisids:Array<Int>=Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        let xib=UINib(nibName: "HistoryTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "historyCell")
        tableView.rowHeight=134
        hisids=Array()
        let hisidtime=dbtools.searchBySQL("SELECT hisid FROM historyTable GROUP BY hisid")
        for item in hisidtime{
            hisids.append(item["hisid"] as! Int)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        hisids=Array()
        let hisidtime=dbtools.searchBySQL("SELECT hisid FROM historyTable GROUP BY hisid")
        for item in hisidtime{
            hisids.append(item["hisid"] as! Int)
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        return hisids.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        let currentHisId = hisids[indexPath.row]
        let hispacks=dbtools.searchHistoryTable(userid: userid, hisid: currentHisId)
        var total:Double=0.0
        for item in hispacks{
            total=total+(item["bookprice"] as! Double)
        }
        let hispack=hispacks[0]
        let book=dbtools.searchBookTable(bookid: hispack["bookid"] as! Int)[0]
        cell.initDisplayData(hisimagepath: book["bookthumbpath"] as! String, hisnametext: (book["bookname"] as! String)+" 等其他商品", histime: hispack["ordertime"] as! String, hisprice: String(format:"%.2f",total))
        

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "displayhisDetail", sender: Any.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayhisDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let next=(segue.destination as! CartTableViewController)
                let hisid=hisids[indexPath.row]
                var books:[[String:AnyObject]]=[]
                for item in dbtools.searchHistoryTable(userid: userid, hisid: hisid){
                    books.append(dbtools.searchBookTable(bookid:item["bookid"] as! Int)[0])
                }
                next.books=books
                next.repreHis()
                
        }
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
