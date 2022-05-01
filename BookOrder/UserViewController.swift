//
//  UserViewController.swift
//  Homework5
//
//  Created by xy Man on 2022/3/16.
//

import UIKit

class UserViewController: UIViewController {

    
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        let loginVC=UserLoginViewController()
               present(loginVC, animated: true, completion: nil)
    }
    @IBAction func registerPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(DBtools().initDB()){getBooksFromURL()
            return}
        // Do any additional setup after loading the view.
    }
    

   

    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
