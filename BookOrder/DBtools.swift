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
            return creatTable(sql: "CREATE TABLE if not exists userTable(userid integer primary key autoincrement,username text not null,password text not null)") && creatTable(sql: "CREATE TABLE if not exists bookTable(bookid integer primary key autoincrement, bookname text not null, bookthumbpath text,bookprice double)") && creatTable(sql: "CREATE TABLE if not exists bookDetailsTable(bookid integer primary key autoincrement, bookimgpath text, bookfixprice double, bookfullname text, bookauthor text, bookISBN text, bookdetailtext text)") && creatTable(sql: "CREATE TABLE if not exists cartTable(userid integer, bookid integer, bookprice double)") && creatTable(sql: "CREATE TABLE if not exists historyTable(userid integer, bookid integer, bookprice double, ordertime text)")}
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
        if (dbManager.openDB()){
        var sql_t=sql
        if (sql.last != ";"){sql_t=sql+";"}
            let result=dbManager.execNoneQuerySQL(sql: sql_t)
            dbManager.closeDB()
            return result
        }
        else{return false}
    }
    //MARK:1 SEARCH
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
    
    
    
    
    
    
    
    
    
}
