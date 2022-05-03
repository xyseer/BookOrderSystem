//
//  CartTableViewController.swift
//  BookOrder
//
//  Created by xy Man on 2022/5/2.
//

import UIKit


class CartTableViewController: UITableViewController {

    var books:[[String:AnyObject]]=[]
    let dbtools=DBtools()

    override func viewDidLoad() {
        super.viewDidLoad()
        let xib=UINib(nibName: "BookTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "bookCell")
        tableView.rowHeight=100
        let cart=dbtools.searchCartTable(userid: userid)
        for item in cart{
            books.append(dbtools.searchBookTable(bookid: item["bookid"] as! Int)[0])
        }
//        NotificationCenter.default.addObserver(self, selector: Selector("refreshPage"), name: NSNotification.Name("homeRefresh"), object: nil)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        books=[]
        let cart=dbtools.searchCartTable(userid: userid)
        for item in cart{
            books.append(dbtools.searchBookTable(bookid: item["bookid"] as! Int)[0])
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
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        let currentBookInfo = books[indexPath.row]
        cell.initDisplayData(userid: userid, bookid: currentBookInfo["bookid"] as! Int, bookThumbPath: currentBookInfo["bookthumbpath"] as? String ?? "", bookName: currentBookInfo["bookname"] as? String ?? "", bookPrice: currentBookInfo["bookprice"] as? Double ?? 0.0)
        cell.hidBut()

        

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "displayDetails", sender: Any.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                (segue.destination as! BookDetailsTableViewController).supercell = tableView(self.tableView, cellForRowAt: indexPath) as! BookTableViewCell
        }
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cartidTool=dbtools.searchCartTable(userid: userid, bookid:books[indexPath.row]["bookid"] as! Int )
            if(!cartidTool.isEmpty){
            if(dbtools.deleteCartTable(cartid: cartidTool[0]["cartid"] as! Int))
            {
            books.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)}
                tabbaritem.badgeValue=String(Int(tabbaritem.badgeValue!)!-1)
            }
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    func refreshPage()
//       {
//
//               //刷新页面
//               self.tableView.reloadData()
//
//       }
//    deinit
//        {
//            NotificationCenter.default.removeObserver(self)
//        }
}
