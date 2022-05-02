//
//  BookDetailViewController.swift
//  BookOrder
//
//  Created by xy Man on 2022/5/2.
//

import UIKit

class BookDetailViewController: UIViewController {
    var supercell:BookTableViewCell=BookTableViewCell()
    @IBOutlet weak var cell: UIView!
    
    @IBOutlet weak var details: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //cell.addSubview(supercell.contentView)
        cell.didAddSubview(supercell.contentView)
        cell.setNeedsDisplay()
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
