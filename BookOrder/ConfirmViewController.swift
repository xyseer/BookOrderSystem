//
//  ConfirmViewController.swift
//  BookOrder
//
//  Created by xy Man on 2022/5/3.
//

import UIKit

class ConfirmViewController: UIViewController {
    let dbtools=DBtools()
    @IBAction func back(_ sender: Any) {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime:String=df.string(from: Date.now)
        let hisid:Int=getValidHisid()
        let currentCart=dbtools.searchCartTable(userid: userid)
        for item in currentCart{
            if(dbtools.writeHistoryTable(hisid: hisid, userid: userid, bookid: item["bookid"] as! Int, bookprice: item["bookprice"] as! Double, ordertime: currentTime)){
                dbtools.deleteCartTable(cartid: item["cartid"] as! Int)
            }
        }

        tabbaritem.badgeValue="0"
        dismiss(animated: true, completion: {cartView.viewWillAppear(true)})
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

func getValidHisid()->Int{
    let dbtools=DBtools()
    for i in 1...Int.max{
        if(dbtools.searchHistoryTable(userid: userid, hisid: i).isEmpty){
            return i
        }
    }
    return -1
}
