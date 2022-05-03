//
//  HistoryTableViewCell.swift
//  BookOrder
//
//  Created by xy Man on 2022/5/3.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    let dbtools=DBtools()
    @IBOutlet weak var hisimage: UIImageView!
    @IBOutlet weak var hisname: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initDisplayData(hisimagepath:String,hisnametext:String,histime:String,hisprice:String){
        hisimage.image=UIImage(contentsOfFile: hisimagepath)
        hisname.text=hisnametext
        time.text="支付时间："+histime
        price.text="总价：￥"+hisprice
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
