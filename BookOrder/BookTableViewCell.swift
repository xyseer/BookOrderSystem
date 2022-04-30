//
//  BookTableViewCell.swift
//  BookOrder
//
//  Created by xy Man on 2022/4/29.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var countInCart: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    var count:Int = 0
    var bookCurrentPrice:Double=0.0
    var bookID:Int = -1
    var userID:Int = -1
    let dbtool=DBtools()
    @IBOutlet weak var cellview: UIView!
    
    @IBAction func add(_ sender: UIButton) {
        if(dbtool.writeCartTable(userid: userID, bookid: bookID, bookprice: bookCurrentPrice)){
            count+=1
            self.countInCart.text=String(count)
        }
        else{
            let p = UIAlertController(title: "添加失败",message:"抱歉，无法添加此书至购物车" ,preferredStyle: .alert)
        p.addAction(UIAlertAction(title:"确定",style:
        .default,
        handler: {(
        act:UIAlertAction ) in
         }
        ))
            cellview.window?.rootViewController?.present(p, animated: true, completion: nil)
        }
    }
    @IBAction func minus(_ sender: UIButton) {
        let cartid:Int = dbtool.searchCartTable(userid: userID, bookid: bookID)[0]["cartid"] as? Int ?? -1
        if((cartid>0) && (dbtool.deleteCartTable(cartid: cartid))){
            count-=1
            self.countInCart.text=String(count)
        }
        else{
            let p = UIAlertController(title: "删除失败",message:"抱歉，购物车中未查到此书" ,preferredStyle: .alert)
        p.addAction(UIAlertAction(title:"确定",style:
        .default,
        handler: {(
        act:UIAlertAction ) in
         }
        ))
            cellview.window?.rootViewController?.present(p, animated: true, completion: nil)
        }
    }
    
    func initDisplayData(userid:Int,bookid:Int,bookThumbPath:String,bookName:String,bookPrice:Double){
        self.userID=userid
        self.bookID=bookid
        self.bookImage.image=UIImage(contentsOfFile: bookThumbPath)
        self.bookName.text=bookName
        self.bookCurrentPrice=bookPrice
        self.bookPrice.text=String(format: "%.2f", bookPrice)
        self.count=dbtool.searchCartTable(userid:userID,bookid: bookid).count
        self.countInCart.text=String(count)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
