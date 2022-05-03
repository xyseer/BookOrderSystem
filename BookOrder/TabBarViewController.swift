//
//  TabBarViewController.swift
//  BookOrder
//
//  Created by xy Man on 2022/5/2.
//

import UIKit
var tabbaritem:UITabBarItem=UITabBarItem()

class TabBarViewController: UITabBarController {
    @IBOutlet weak var tabbar: UITabBar!
    let dbtools=DBtools()

    override func viewDidLoad() {
        super.viewDidLoad()

        tabbaritem=tabbar.items![1]
        tabbar.items![1].badgeValue=String(dbtools.searchBySQL("SELECT * FROM cartTable").count)
        self.tabBarController?.delegate = self as? UITabBarControllerDelegate

        // Do any additional setup after loading the view.
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        (self.viewControllers![1] as! CartTableViewController).viewWillAppear(true)
    }
        

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
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
