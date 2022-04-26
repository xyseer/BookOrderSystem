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
        print(FileManager.default.urls(for:.documentDirectory,in:.userDomainMask).first!)
    }
    func initDB()->Bool{
        if (searchBySQL("select * from sqlite_master where type='table'").isEmpty){
            return creatTable(sql: "CREATE TABLE if not exists userTable(userid integer primary key autoincrement,username text not null,password text not null)") && creatTable(sql: "CREATE TABLE if not exists bookTable(bookid integer primary key autoincrement, bookname text not null, bookthumbpath text,bookprice double not null, bookcategory text)") && creatTable(sql: "CREATE TABLE if not exists bookDetailsTable(bookid integer primary key autoincrement, bookimgpath text, bookfixprice double, bookfullname text, bookauthor text, bookISBN text, bookdetailtext text)") && creatTable(sql: "CREATE TABLE if not exists cartTable(userid integer not null, bookid integer not null, bookprice double not null)") && creatTable(sql: "CREATE TABLE if not exists historyTable(userid integer not null, bookid integer, bookprice double, ordertime text)")}
        else {return true}
        
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
    
    func searchCartTable(userid:Int)->[[String:AnyObject]]{
        return searchBySQL("SELECT * FROM 'cartTable' WHERE userid=\(userid)")
    }
    
    func searchHistoryTable(userid:Int)->[[String:AnyObject]]{
        return searchBySQL("SELECT * FROM 'historyTable' WHERE userid=\(userid)")
    }
    
    
    // MARK:2 WRITE
    
    func writeUserTable(userid:Int,username:String,password:String)->Bool{
        return execNoneQuery("INSERT INTO userTable values(\(userid),'\(username)','\(password)')")
    }
    
    
    
    
    
}
