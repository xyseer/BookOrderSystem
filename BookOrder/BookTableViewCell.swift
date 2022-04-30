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
    var bookID:Int = -1
    var userID:Int = -1
    let dbtool=DBtools()
    
    @IBAction func add(_ sender: UIButton) {
    }
    @IBAction func minus(_ sender: UIButton) {
    }
    
    func initDisplayData(userid:Int,bookid:Int,bookThumbPath:String,bookName:String,bookPrice:Double){
        self.userID=userid
        self.bookID=bookid
        self.bookImage.image=UIImage(contentsOfFile: bookThumbPath)
        self.bookName.text=bookName
        self.bookPrice.text=String(format: "%.2f", bookPrice)
        self.countInCart.text=String(dbtool.searchCartTable(userid:userID,bookid: bookid).count)
        
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
