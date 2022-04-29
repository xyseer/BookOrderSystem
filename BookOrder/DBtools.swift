//
//  DBtools.swift
//  BookOrder
//
//  Created by xy Man on 2022/4/26.
//

import Foundation

class DBtools{
    private let dbManager=SQLiteManager.sharedInstance
    init(){
//        print(FileManager.default.urls(for:.documentDirectory,in:.userDomainMask).first!)
    }
    func initDB()->Bool{
            return creatTable(sql: "CREATE TABLE if not exists userTable(userid integer primary key autoincrement,username text not null unique,password text not null)") && creatTable(sql: "CREATE TABLE if not exists bookTable(bookid integer primary key autoincrement, bookname text not null, bookthumbpath text,bookprice double not null, bookcategory text)") && creatTable(sql: "CREATE TABLE if not exists bookDetailsTable(bookid integer primary key autoincrement, bookimgpath text, bookfixprice double, bookfullname text, bookauthor text, bookISBN text, bookdetailtext text)") && creatTable(sql: "CREATE TABLE if not exists cartTable(cartid integer unique, userid integer not null, bookid integer not null, bookprice double not null)") && creatTable(sql: "CREATE TABLE if not exists historyTable(hisid integer, userid integer not null, bookid integer, bookprice double, ordertime text)")
        
    }
    
    func creatTable(sql:String)->Bool{
        if (dbManager.openDB()){
            if(dbManager.execNoneQuerySQL(sql: sql)){
                dbManager.closeDB()
                return true
            }
            else{
                dbManager.closeDB()
                return false
            }
        }
        else{
            return false
        }
    }
    
    func execNoneQuery(_ sql:String)->Bool{
        var sql_t=sql
        if (sql.last != ";"){sql_t=sql+";"}
        return creatTable(sql: sql_t)
    }
    // MARK:1 SEARCH
    func searchBySQL(_ sql:String)->[[String:AnyObject]]{
        if (dbManager.openDB()){
        var sql_t=sql
        if (sql.last != ";"){sql_t=sql+";"}
            let result=dbManager.execQuerySQL(sql: sql_t) ?? []
            dbManager.closeDB()
            return result
        }
        else{return []}
    }
    
    func searchUserTable(userid:Int = -1,username:String="")->[[String:AnyObject]]{
        return searchBySQL("SELECT * FROM 'userTable' WHERE username='\(username)' or userid=\(userid)")
    }
    
    func searchBookTable(bookid:Int = -1,bookname:String="",bookcategory:String="")->[[String:AnyObject]]{
        if (bookcategory != "")
        {return searchBySQL("SELECT * FROM 'bookTable' WHERE bookname='\(bookname)' or userid=\(bookid) or bookcategory='\(bookcategory)'")}
        else{return searchBySQL("SELECT * FROM 'bookTable' WHERE bookname='\(bookname)' or userid=\(bookid)")}
    }
    
    func searchBookDetailsTable(bookid:Int = -1,bookfullname:String="")->[[String:AnyObject]]{
        return searchBySQL("SELECT * FROM 'bookDetailsTable' WHERE bookfullname='\(bookfullname)' or bookid=\(bookid)")
    }
    
    func searchCartTable(userid:Int = -1,bookid:Int = -1)->[[String:AnyObject]]{
        return searchBySQL("SELECT * FROM 'cartTable' WHERE userid=\(userid) or bookid=\(bookid)")
    }
    
    func searchHistoryTable(userid:Int = -1,hisid:Int = -1)->[[String:AnyObject]]{
        return searchBySQL("SELECT * FROM 'historyTable' WHERE userid=\(userid) or hisid=\(hisid)")
    }
    
    
    // MARK:2 WRITE
    
    func writeUserTable(userid:Int,username:String,password:String)->Bool{
        return execNoneQuery("INSERT INTO userTable values(\(userid),'\(username)','\(password)')")
    }
    
    func writeBookTable(bookid:Int,bookname:String,bookthumbpath:String,bookprice:Double,bookcategory:String)->Bool{
        return execNoneQuery("INSERT INTO bookTable values(\(bookid),'\(bookname)','\(bookthumbpath)',\(bookprice),'\(bookcategory)')")
    }
    
    func writeBookDetailsTable(bookid:Int,bookimgpath:String,bookfixprice:Double,bookfullname:String,bookauthor:String,bookISBN:String,bookdetailtext:String)->Bool{
        return execNoneQuery("INSERT INTO bookDetailsTable values(\(bookid),'\(bookimgpath)',\(bookfixprice),'\(bookfullname)','\(bookauthor)','\(bookISBN)','\(bookdetailtext)')")
    }
    
    func writeCartTable(cartid:Int,userid:Int,bookid:Int,bookprice:Double)->Bool{
        return execNoneQuery("INSERT INTO cartTable values(\(cartid),\(userid),\(bookid),\(bookprice))")
    }
    
    func writeHistoryTable(hisid:Int,userid:Int,bookid:Int,bookprice:Double,ordertime:String)->Bool{
        return execNoneQuery("INSERT INTO historyTable values(\(hisid),\(userid),\(bookid),\(bookprice),'\(ordertime)')")
    }
    
    //MARK:3 DELETE
    
    func deleteUserTable(userid:Int)->Bool{
        var result:Bool=true
        result=execNoneQuery("DELETE FROM userTable where userid=\(userid)")&&result
        result=execNoneQuery("DELETE FROM cartTable where userid=\(userid)")&&result
        result=execNoneQuery("DELETE FROM historyTable where userid=\(userid)")&&result
        return result
    }
    // bookTable and bookdetailsTable cannot simply delete otherwise bugs occured (e.g. cartTable has invalid bookid
    
    func deleteCartTable(cartid:Int,bookid:Int = -1)->Bool{
        return execNoneQuery("DELETE FROM cartTable where cartid=\(cartid) or bookid=\(bookid)")
        
    }
    
    func deleteHistoryTable(hisid:Int)->Bool{
        return execNoneQuery("DELETE FROM historyTable where hisid=\(hisid)")
    }
    
    
//    //MARK:4 UPDATE
    
    func updateUserTable(original_userid:Int,after_username:String="",after_password:String="")->Bool{
        if (after_password != ""){
            return execNoneQuery("UPDATE userTable set username='\(after_username)',password='\(after_password)' where userid=\(original_userid)")}
        else{
            return execNoneQuery("UPDATE userTable set username='\(after_username)' where userid=\(original_userid)")
        }
    }// only packaged the update of userTable, others will update by delete and write.
    
    func updateBookTable(origin_bookid:Int,bookname:String,bookthumbpath:String,bookprice:Double,bookcategory:String)->Int{
        if (execNoneQuery("delete from bookTable where bookid=\(origin_bookid)")){
            if (execNoneQuery("INSERT INTO bookTable(bookname,bookthumbpath,bookprice,bookcategory)  values('\(bookname)','\(bookthumbpath)',\(bookprice),'\(bookcategory)')")){
                let idlist=searchBookTable(bookname: bookname, bookcategory: bookcategory)
                if (!idlist.isEmpty){
                    return Int(idlist[0]["bookid"] as? String ?? "-1") ?? -1
                }
                else{return -1}
            }
            else {return -1}
        }
        else{return origin_bookid}
        
    }
    
    func updateBookDetailsTable(origin_bookid:Int,bookimgpath:String = "",bookfixprice:Double = -1.0 ,bookfullname:String="",bookauthor:String="",bookISBN:String="",bookdetailtext:String="")->Bool{
        var sql:String="UPDATE bookDetailsTable set "
        if (bookimgpath != ""){sql+="bookimgpath='\(bookimgpath)',"}
        if(bookfixprice != -1.0){sql+="bookfixprice=\(bookfixprice),"}
        if (bookfullname != ""){sql+="bookfullname='\(bookfullname)',"}
        if (bookauthor != ""){sql+="bookauthor='\(bookauthor)',"}
        if (bookISBN != ""){sql+="bookISBN='\(bookISBN)',"}
        if (bookdetailtext != ""){sql+="bookdetailtext='\(bookdetailtext)',"}
        if(sql.last == ","){sql = String(sql.dropLast(1))
            return execNoneQuery(sql+" where userid=\(origin_bookid)")}
        else {return false}
        
    }

    //cartTable and historyTable do not need to update. Only delete and write operations are required.
    

    
    
    
    
    
    
}
