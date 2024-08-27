//
//  ViewController.swift
//  ioscoredatastudy
//
//  Created by kenan on 25.08.2024.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    var userList = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        saveData()
        readData()
    }
    
    func saveData(){
        let user = User(context:context)
        user.user_name = "Kenan"
        user.user_age = 24

        appDelegate.saveContext()
    }
   
    func readData(){
        do{
            userList = try context.fetch(User.fetchRequest())
        }catch{
            print("veri okurken hata oluştu")
        }
        
        for user in userList {
             if let name = user.user_name {
                 print("Ad: \(name) - Yaş: \(user.user_age)")
             } else {
                 print("Ad: Bilinmiyor - Yaş: \(user.user_age)")
             }
         }
    }
    
    func deleteData(){
        let user = userList[1]
        context.delete(user)
        appDelegate.saveContext()
    }
    
    func updateData(){
        let user = userList[1]
        user.user_name = "Güncel isim"
        user.user_age = 99
        appDelegate.saveContext()
    }
    
    func orderData(){
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        let sort = NSSortDescriptor(key:#keyPath(User.user_age),ascending: false)
        
        fetchRequest.sortDescriptors = [sort]
        
        do{
            userList = try context.fetch(fetchRequest)
        }catch{
            print("veri okurken hata oluştu.")
        }
        
        for user in userList {
             if let name = user.user_name {
                 print("Ad: \(name) - Yaş: \(user.user_age)")
             } else {
                 print("Ad: Bilinmiyor - Yaş: \(user.user_age)")
             }
         }
    }
    
    func filterData(){
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "user_age == %i", 23)
        do{
            userList = try context.fetch(fetchRequest)
        }catch{
            print("cannot fetch ")
        }
        
        for user in userList {
            if let name = user.user_name{
                print("Ad: \(name) - Yaş: \(user.user_age)")
            }else {
                print("Ad: Bilinmiyor - Yaş: \(user.user_age)")
            }
        }
    }


}

