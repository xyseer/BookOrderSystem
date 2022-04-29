//
//  UserRegisterViewController.swift
//  Homework5
//
//  Created by xy Man on 2022/3/16.
//

import UIKit

class UserRegisterViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var userpassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBAction func confirmPressed(_ sender: UIButton) {
        let usernameWillRegister=self.username.text ?? ""
        let userpasswordWillRegister=self.userpassword.text ?? ""
        let dbtool=DBtools()
        if ((usernameWillRegister != "")&&(userpasswordWillRegister != "")&&(dbtool.searchUserTable(username: usernameWillRegister).isEmpty)&&(dbtool.writeUserTable(username: usernameWillRegister, password:userpasswordWillRegister))){
            let p = UIAlertController(title: "注册成功",message:"用户\(usernameWillRegister)注册成功" ,preferredStyle: .alert)
        p.addAction(UIAlertAction(title:"确定",style:
        .default,
        handler: {(
        act:UIAlertAction ) in
        self.username.text = ""
            self.userpassword.text = ""
            self.dismiss(animated: true, completion: nil)
        }
        ))
            
                present (p, animated: true, completion:nil)
        }
        else{
        let p = UIAlertController(title: "注册失败",message:"用户名已存在或用户名密码为空" ,preferredStyle: .alert)
    p.addAction(UIAlertAction(title:"确定",style:
    .default,
    handler: {(
    act:UIAlertAction ) in
    self.username.text = ""
        self.userpassword.text = ""
    }
    ))
        
            present (p, animated: true, completion: nil)}
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
