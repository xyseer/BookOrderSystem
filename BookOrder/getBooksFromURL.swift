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
               print(jsonData)
           } catch {
               print("解析出错")
           }
       }.resume()
      print("executed")
    
}
