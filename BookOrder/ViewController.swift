//
//  ViewController.swift
//  BookOrder
//
//  Created by xy Man on 2022/4/25.
//

import UIKit

class ViewController: UIViewController {

    let dbtool=DBtools()
    override func viewDidLoad() {
        super.viewDidLoad()
        dbtool.initDB()
        // Do any additional setup after loading the view.
    }
    @IBAction func test_button_clicked(_ sender: Any) {
        print(dbtool.searchUserTable(username: "xy"))
        print(dbtool.creatTable(sql: "insert into userTable('userid','username','password') values (1,'xy','123456')"))
        print(dbtool.searchUserTable(username: "xy"))
    }
    
    @IBOutlet weak var llabel: UILabel!

}

