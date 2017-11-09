//
//  DatabaseManagement.swift
//  DemoSQLite
//
//  Created by Manuh on 10/25/17.
//  Copyright © 2017 Manuh. All rights reserved.
//

import Foundation
import SQLite

class Databasemanagement
{
    static let shared: Databasemanagement = Databasemanagement()
    
    private let db: Connection?
    
    private let tblProduct = Table("product")
    private let id = Expression<Int64>("id")
    private let name = Expression<String>("name")
    private let imageName = Expression<String>("imageName")
    
    
    init()
    {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do
        {
            print(path)
            db = try Connection("\(path)/test.sqlite3")
            
            createTableProduct()
            
            //let insertedId = addProduct(inputName: "book1", inputImageName: "book image1")
            //print("InsertedId: \(insertedId)")
            
            
            
            //updateContact(prodId: 1, newProd: Product(id: 1, name: "book1", imageName: "image1"))
            
            deleteProduct(inputId: 4)
            quaryAllProduct()
        }
        catch
        {
            db = nil
            print("Unable to open database")
        }
    }
    
    func createTableProduct()
    {
        do
        {
            try db?.run(tblProduct.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(imageName)
            }))
            
            print("Create table successfully")
        }
        catch
        {
            print("Unable to create table")
        }
    }
    
    func addProduct(inputName: String, inputImageName: String) -> Int64?
    {
        do {
            let insert = tblProduct.insert(name <- inputName, imageName <- inputImageName)
            let id = try db?.run(insert)
            
            print("Insert tableProduct is success")
            
            return (id)
        }
        catch
        {
            print("Can not insert to database")
            
            return nil
        }
    }
    
    func quaryAllProduct()
    {
        do {
            for product in try db!.prepare(self.tblProduct)
            {
                let id = product[self.id]
                let name = product[self.name] 
                let imagename = product[imageName]
                
                print("id: \(id) name: \(name) imageName: \(imagename)")
            }
            
        }
        catch
        {
            print("can not get list of products")
        }
    }
    
    func updateContact(prodId: Int64, newProd: Product) -> Bool
    {
        let tblFilterdProd = tblProduct.filter(id == prodId)
        
        do {
            let update = tblFilterdProd.update([
                name <- newProd.name,
                imageName <- newProd.imageName
                ])
            
            if try db!.run(update) > 0
            {
                print("Update success")
                return true
            }
            
        }
        catch
        {
            print("Update failed: \(error)")
        }
        
        return false
    }
    
    func deleteProduct(inputId: Int64) -> Bool
    {
        do {
            let prodTableRow = tblProduct.filter(id == inputId)
            try db!.run(prodTableRow.delete())
            print("delete success")
            
            return true
            
        } catch
        {
            print("Delete fail")
        }
        
        return false
    }
    
}
