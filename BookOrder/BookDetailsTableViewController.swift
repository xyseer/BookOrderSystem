//
//  BookDetailsTableViewController.swift
//  BookOrder
//
//  Created by xy Man on 2022/5/2.
//

import UIKit

class BookDetailsTableViewController: UITableViewController {
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    var supercell:BookTableViewCell=BookTableViewCell()
    let dbtools=DBtools()

    override func viewDidLoad() {
        super.viewDidLoad()
        let xib=UINib(nibName: "BookTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "bookCell")
        tableView.rowHeight=100
        let bookdetails=dbtools.searchBookDetailsTable(bookid: supercell.bookID)
        if (bookdetails.isEmpty){detailLabel.text="暂无详细信息！"}
        else{
            detailLabel.text="作者：\(bookdetails[0]["bookauthor"] as! String)\n\nISBN号：\(bookdetails[0]["bookISBN"] as! String)\n\n定价：\(bookdetails[0]["bookfixprice"] as! Double)\n\n内容详情：\(bookdetails[0]["bookdetailtext"] as! String)"
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
//        cell.userID=supercell.userID
//        cell.bookID=supercell.bookID
//        cell.bookImage.image=supercell.bookImage.image
//        cell.bookName.text=supercell.bookName.text
//        cell.bookPrice.text=supercell.bookPrice.text
//        cell.countInCart.text=supercell.countInCart.text
//        cell.count=supercell.count
//        print(cell.count)
//        print(cell.bookName)
        

        // Configure the cell...

        return supercell
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        performSegue(withIdentifier: "displayDetails", sender: Any.self)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "booktablewithcategory" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                (segue.destination as! BookDetailViewController).supercell = tableView(self.tableView, cellForRowAt: indexPath) as! BookTableViewCell
//        }
//        }
//    }
    

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
