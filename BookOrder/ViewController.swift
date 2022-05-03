//
//  ViewController.swift
//  BookOrder
//
//  Created by xy Man on 2022/4/25.
//

import UIKit

class ViewController: UIViewController {

    let dbtool=DBtools()
    override func viewWillAppear(_ animated: Bool) {
        beginAppearanceTransition(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dbtool.initDB()
//        getBooksFromURL()
//        dbtool.execNoneQuery("drop table userTable")
//        dbtool.execNoneQuery("drop table bookTable")
//        dbtool.execNoneQuery("drop table bookDetailsTable")
//        dbtool.execNoneQuery("drop table cartTable")
        dbtool.execNoneQuery("drop table historyTable")
        // Do any additional setup after loading the view.
    }
    @IBAction func test_button_clicked(_ sender: Any) {
        print(dbtool.searchUserTable(username: "xy"))
        dbtool.writeCartTable(cartid:1,userid: 1, bookid: 1, bookprice: 1.11)
        dbtool.writeUserTable(userid: 2, username: "lzy", password: "125t54")
        dbtool.writeBookTable(bookname: "吃出自愈力", bookthumbpath: "http://zy.whu.edu.cn/cs/img/29219294-1_l_18.jpg", bookprice: 39.00, bookcategory: "养生")
        print(dbtool.searchUserTable(username: "xy"))
        print(dbtool.searchUserTable(userid:1))
        print(dbtool.searchUserTable(userid:2))
        print(dbtool.searchCartTable(userid: 1))
        dbtool.deleteUserTable(userid: 1)
        print(dbtool.searchBySQL("SELECT * FROM bookTable"))
        print(dbtool.searchUserTable(userid:2))
        print(dbtool.searchCartTable(userid: 1))
    }
    
    @IBOutlet weak var llabel: UILabel!

}

