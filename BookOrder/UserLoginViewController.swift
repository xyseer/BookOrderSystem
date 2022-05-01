//
//  UserLogin.swift
//  Homework5
//
//  Created by xy Man on 2022/3/16.
//
var userid:Int = -1

import UIKit
class UserLoginViewController:UIViewController
{
var txtUser:UITextField!
var txtPwd:UITextField!
var btnLogin:UIButton!
    var btnExit:UIButton!

override func viewDidLoad() {
super.viewDidLoad()
//获取屏幕尺寸
let mainSize = UIScreen.main.bounds.size
//登录框背景
let vLogin =
UIView(frame:CGRect (x: 30, y: 200, width:
mainSize.width - 30, height: 250))
vLogin.layer.borderWidth = 0.5
vLogin.layer.borderColor=UIColor.lightGray.cgColor
vLogin.backgroundColor=UIColor.white
self.view.addSubview(vLogin)
//用户名输入框
txtUser = UITextField(frame: CGRect(x: 30, y: 30, width:
vLogin.frame.size.width
- 60, height: 44))
//txtUser.delegate = self
txtUser.layer.cornerRadius=5
txtUser.layer.borderColor=UIColor.lightGray.cgColor
txtUser.layer.borderWidth=0.5

vLogin.layer.borderColor = UIColor.lightGray.cgColor
vLogin.backgroundColor=UIColor.white
self.view.addSubview(vLogin)

//用户名输入框
txtUser = UITextField(frame:CGRect (x: 30, y: 30, width:
vLogin.frame.size.width - 60, height: 44))
//txtUser.delegate = self
txtUser.layer.cornerRadius=5
txtUser.layer.borderColor=UIColor.lightGray.cgColor
txtUser.layer.borderWidth=0.5
txtUser.autocapitalizationType = .none
txtUser.leftView = UIView(frame:CGRect(x: 0, y:0, width:
44, height: 44))
txtUser.leftViewMode=UITextField.ViewMode.always
    txtUser.text = loadLastUserName()
//用户名输入框左侧图标
let imgUser =
UIImageView(frame:CGRect (x: 11, y: 11,
width: 22, height: 22))
imgUser.image = UIImage (named: "iconfont-user")
txtUser.leftView!.addSubview(imgUser)
vLogin.addSubview(txtUser)
//密码输入框
txtPwd = UITextField(frame:CGRect(x: 30, y: 90, width:
vLogin.frame.size.width - 60, height: 44) )
//txtPwd.delegate = self
txtPwd.layer.cornerRadius=5
txtPwd.layer.borderColor = UIColor.lightGray.cgColor
txtPwd.layer.borderWidth = 0.5
txtPwd.isSecureTextEntry=true
txtPwd.leftView = UIView(frame:CGRect(x: 0, y: 0, width:
44, height: 44))
txtPwd.leftViewMode=UITextField.ViewMode.always
//密码输入框左侧圈标
let imgPwd = UIImageView(frame:CGRect (x: 11, y: 11,
width: 22, height: 22))
imgPwd.image = UIImage (named: "iconfont-password")
txtPwd.leftView!.addSubview(imgPwd)
vLogin.addSubview(txtPwd)
//添加登录按钮
btnLogin = UIButton(frame:CGRect (x:
mainSize.width/2-120/2-80, y: 150, width: 120, height:
50))
btnLogin.setTitle( "登录",for: .normal)
btnLogin.backgroundColor = UIColor.gray
vLogin.addSubview(btnLogin)
//add action
btnLogin.addTarget(self, action: #selector(loginEvent),
for: .touchUpInside)
//add exit button
    btnExit = UIButton(frame:CGRect (x:mainSize.width/2+20, y: 150, width: 120, height:
    50))
    btnExit.setTitle( "关闭",for: .normal)
    btnExit.backgroundColor = UIColor.gray
    vLogin.addSubview(btnExit)
    //add action
    btnExit.addTarget(self, action: #selector(exitevent),
    for: .touchUpInside)
}
    
    
    @objc func exitevent(){
        dismiss(animated: true, completion: nil)
    }
    
    
@objc func loginEvent () {
let usercode = txtUser.text!
let password = txtPwd.text!
txtUser.resignFirstResponder()
txtPwd.resignFirstResponder()
    let dbtool=DBtools()
    let result=dbtool.searchUserTable(username: usercode)
    if((!result.isEmpty) && result[0]["password"] as! String==password)
{
let mainBoard:UIStoryboard!=UIStoryboard(name:
"Main", bundle: nil)
let VCMain =
mainBoard!
.instantiateViewController(withIdentifier:
"test")//vcMain//test
        
        
//    (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows[0].rootViewController=VCMain
//UIApplication.shared.windows[0].rootViewController=VCMain
    do{
    let path=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("UserDefaults").path
        try usercode.write(toFile: path, atomically: true, encoding: .utf8)}
    catch{}
        dismiss (animated: true, completion: {(UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows[0].rootViewController=VCMain})
        userid=result[0]["userid"] as! Int

        
}
else
{
//self.dismiss (animated: true, completion: nil)

    let p = UIAlertController(title: "登录失败",message:"用户名或密码错误" ,preferredStyle: .alert)
p.addAction(UIAlertAction(title:"确定",style:
.default,
handler: {(
act:UIAlertAction ) in
self.txtPwd.text = "" }
))
    
present (p, animated: true, completion: nil)
}
}
}



func loadLastUserName()->String{
    let path=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let url:URL=path.appendingPathComponent("UserDefaults")
    if (!FileManager.default.fileExists(atPath: url.path)){
        FileManager.default.createFile(atPath: url.path, contents: nil, attributes: nil)
        return ""
    }
    do{
        return try String(contentsOfFile: url.path, encoding: .utf8)
        
    }
    catch{
        return ""
    }
    
}
