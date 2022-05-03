//
//  getBooksFromURL.swift
//  BookOrder
//
//  Created by xy Man on 2022/5/1.
//

import Foundation
import WebKit

func getBooksFromURL()->Void{
    let url:URL = URL(string: "http://zy.whu.edu.cn/cs/api/book/list")!
    print(url)
    let dbtools=DBtools()

    URLSession.shared.dataTask(with: url) { (objectData, response, error) in
           guard error == nil else {
               print("网络出错:\(error!.localizedDescription)")
               return
           }
           
           guard objectData != nil else {
               print("数据为空：")
               return
           }
           
           do {
               let jsonData = try JSONSerialization.jsonObject(with: objectData!, options: .mutableContainers)
               let dic = jsonData as? Dictionary<String,AnyObject> ?? [:]
               let result = dic["result"] as? Array<Dictionary<String,AnyObject>> ?? []
               for book in result{
                   let id:String=book["id"] as? String ?? "no_book"
                   let author:String=book["author"] as? String ?? ""
                   let title:String=book["title"] as? String ?? ""
                   let code:String=book["code"] as? String ?? ""
                   let kind:String=book["kind"] as? String ?? ""
                   let pic:String=book["pic"] as? String ?? ""
                   let description:String=book["description"] as? String ?? ""
                   let price:Double=Double(book["price"] as? String ?? "") ?? 0.0
                   let pathImg:String=FileManager.default.urls(for:.documentDirectory,in:.userDomainMask).first!.appendingPathComponent("\(id).jpg").path
                   downloadImg(url:URL(string: pic)!, filename: id)
                   var booktmp=dbtools.searchBookTable(bookname: title)
                   if(booktmp.isEmpty){
                       if(dbtools.writeBookTable(bookname: title, bookthumbpath: pathImg, bookprice: price, bookcategory: kind)){
                   booktmp=dbtools.searchBookTable(bookname: title)
                   if(!booktmp.isEmpty){
                       let bookid:Int=booktmp[0]["bookid"] as? Int ?? -1
                       if(bookid>0){
                           dbtools.writeBookDetailsTable(bookid: bookid, bookimgpath: pathImg, bookfixprice: price, bookfullname: title, bookauthor: author, bookISBN: code, bookdetailtext: description)
                       }
                       
                   }
                   }
                   }
                   else{
                       dbtools.updateBookPath(bookid: booktmp[0]["bookid"] as? Int ?? -1, bookthumbpath: pathImg)
                   }
                   
                   
               }
           } catch {
               print("解析出错")
           }
       }.resume()
      print("executed")
    
}

func downloadImg(url:URL,filename:String) ->Void {
    URLSession.shared.dataTask(with: url) { (objectData, response, error) in
           guard error == nil else {
               print("网络出错:\(error!.localizedDescription)")
               return
           }
           
           guard objectData != nil else {
               print("数据为空：")
               return
           }
        if let objectData = objectData{
            do{
                let target=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("\(filename).jpg")
                try objectData.write(to: target)
            }
            catch{
                print("写文件失败！")
            }
        }
    }.resume()

}
